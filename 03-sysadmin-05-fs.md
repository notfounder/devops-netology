# 3.5. Файловые системы

1. Что такое разрежённый файл ([sparse-файлах](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB))?

   **Разрежённый файл** (англ. sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях (список дыр).

   **Дыра** (англ. hole) — последовательность нулевых байт внутри файла, не записанная на диск. Информация о дырах (смещение от начала файла в байтах и количество байт) хранится в метаданных файловой системы.

   Типы ФС поддерживающие разрежённые файлы: BTRFS, NILFS, ZFS, NTFS[2], ext2, ext3, ext4, XFS, JFS, ReiserFS, Reiser4, UFS, Rock Ridge, UDF, ReFS, APFS, F2FS.

2. Могут ли файлы, являющиеся жёсткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

     Нет не могут, т.к. жесткая ссылка имеет тот же inode что и оригинальный файл.

3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

     ```ruby
     Vagrant.configure("2") do |config|
       config.vm.box = "bento/ubuntu-20.04"
       config.vm.provider :virtualbox do |vb|
         lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
         lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
         vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
         vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
         vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
         vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
       end
     end
     ```

     Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

     Моя конфигурация Vagrantfile:

     ```ruby
     path_to_disk1 = "/Users/notfounder/VMs/vm-parallels/disk0.hdd"
     path_to_disk2= "/Users/notfounder/VMs/vm-parallels/disk1.hdd"
     
     host_params = {
         'cpus'=>2,
         'memory'=>2048,
         'hostname'=>'sysadm-fs',
         'vm_name'=>'sysadm-fs'
     }
     
     # Моя конфигурация для провайдера parallels:
     Vagrant.configure("2") do |config|
       config.vm.box = "bento/ubuntu-20.04-arm64"
       config.vm.hostname=host_params['hostname']
       config.vm.provider :parallels do |prl|
         prl.name=host_params['vm_name']
         prl.cpus=host_params['cpus']
         prl.memory=host_params['memory']
         prl.customize ["set", :id, "--device-add", "hdd", "--image", path_to_disk1, "--size", "2560", "--enable"]
         prl.customize ["set", :id, "--device-add", "hdd", "--image", path_to_disk2, "--size", "2560", "--enable"]
       end
       config.vm.network "private_network", type: "dhcp"
     end
     ```

     Проверяем:

     ![03-sysadmin-05-fs_01.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_01.jpg?raw=true)

4. Используя fdisk, разбейте первый диск на два раздела: 2 Гб и оставшееся пространство.

     Решение:

     ![03-sysadmin-05-fs_02.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_02.jpg?raw=true)

     ![03-sysadmin-05-fs_03.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_03.jpg?raw=true)

5. Используя sfdisk, перенесите эту таблицу разделов на второй диск.

     Решение:

     ![03-sysadmin-05-fs_04.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_04.jpg?raw=true)

6. Соберите mdadm RAID1 на паре разделов 2 Гб.

     Решение:

     ![03-sysadmin-05-fs_05.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_05.jpg?raw=true)

7. Соберите mdadm RAID0 на второй паре маленьких разделов.

     Решение:

     ![03-sysadmin-05-fs_06.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_06.jpg?raw=true)

8. Создайте два независимых PV на получившихся md-устройствах.

     Решение:

     ```sh
     vagrant@sysadm-fs:~$ sudo pvcreate /dev/md1 /dev/md0
       Physical volume "/dev/md1" successfully created.
       Physical volume "/dev/md0" successfully created.
     ```

9. Создайте общую volume-group на этих двух PV.

     Решение:

     ```sh
     vagrant@sysadm-fs:~$ sudo vgcreate vg1 /dev/md1 /dev/md0
       Volume group "vg1" successfully created
     vagrant@sysadm-fs:~$ sudo vgdisplay vg1
       --- Volume group ---
       VG Name               vg1
       System ID
       Format                lvm2
       Metadata Areas        2
       Metadata Sequence No  1
       VG Access             read/write
       VG Status             resizable
       MAX LV                0
       Cur LV                0
       Open LV               0
       Max PV                0
       Cur PV                2
       Act PV                2
       VG Size               <2.99 GiB
       PE Size               4.00 MiB
       Total PE              765
       Alloc PE / Size       0 / 0
       Free  PE / Size       765 / <2.99 GiB
       VG UUID               fxSZL7-J7IM-GHge-x2bC-bcpS-z4Rq-4aL6sI
     ```

10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

     Решение:

     ```sh
     vagrant@sysadm-fs:~$ sudo lvcreate -L 100M vg1 /dev/md0
       Logical volume "lvol0" created.
     ```

11. Создайте mkfs.ext4 ФС на получившемся LV.

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ sudo mkfs.ext4 /dev/vg1/lvol0
      mke2fs 1.45.5 (07-Jan-2020)
      Discarding device blocks: done
      Creating filesystem with 25600 4k blocks and 25600 inodes
      
      Allocating group tables: done
      Writing inode tables: done
      Creating journal (1024 blocks): done
      Writing superblocks and filesystem accounting information: done
      ```

12. Смонтируйте этот раздел в любую директорию, например, /tmp/new

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ sudo mkdir /tmp/new
      vagrant@sysadm-fs:~$ sudo mount /dev/vg1/lvol0 /tmp/new
      ```

13. Поместите туда тестовый файл, например, wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
      --2023-04-03 15:42:41--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
      Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
      Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
      HTTP request sent, awaiting response... 200 OK
      Length: 24666958 (24M) [application/octet-stream]
      Saving to: ‘/tmp/new/test.gz’
      
      /tmp/new/test.gz                       100%[=========================================================================>]  23.52M  4.98MB/s    in 4.7s
      
      2023-04-03 15:42:46 (4.98 MB/s) - ‘/tmp/new/test.gz’ saved [24666958/24666958]
      ```

14. Прикрепите вывод lsblk

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ lsblk
      NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
      loop0                       7:0    0 57.9M  1 loop  /snap/core20/1614
      loop1                       7:1    0   61M  1 loop  /snap/lxd/22761
      loop3                       7:3    0 43.2M  1 loop  /snap/snapd/18600
      loop4                       7:4    0 59.1M  1 loop  /snap/core20/1856
      loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24065
      sda                         8:0    0   64G  0 disk
      ├─sda1                      8:1    0  1.1G  0 part  /boot/efi
      ├─sda2                      8:2    0    2G  0 part  /boot
      └─sda3                      8:3    0   61G  0 part
        └─ubuntu--vg-ubuntu--lv 253:0    0 30.5G  0 lvm   /
      sdb                         8:16   0  2.5G  0 disk
      ├─sdb1                      8:17   0    2G  0 part
      │ └─md1                     9:1    0    2G  0 raid1
      └─sdb2                      8:18   0  511M  0 part
        └─md0                     9:0    0 1018M  0 raid0
          └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
      sdc                         8:32   0  2.5G  0 disk
      ├─sdc1                      8:33   0    2G  0 part
      │ └─md1                     9:1    0    2G  0 raid1
      └─sdc2                      8:34   0  511M  0 part
        └─md0                     9:0    0 1018M  0 raid0
          └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
      sr0                        11:0    1 1024M  0 rom 
      ```

15. Протестировал целостность файла:

      ```sh
      vagrant@sysadm-fs:~$ gzip -t /tmp/new/test.gz
      vagrant@sysadm-fs:~$ echo $?
      0
      ```

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ sudo pvmove /dev/md0
        /dev/md0: Moved: 100.00%
      vagrant@sysadm-fs:~$ lsblk
      NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
      loop0                       7:0    0 57.9M  1 loop  /snap/core20/1614
      loop1                       7:1    0   61M  1 loop  /snap/lxd/22761
      loop3                       7:3    0 43.2M  1 loop  /snap/snapd/18600
      loop4                       7:4    0 59.1M  1 loop  /snap/core20/1856
      loop5                       7:5    0 91.9M  1 loop  /snap/lxd/24065
      sda                         8:0    0   64G  0 disk
      ├─sda1                      8:1    0  1.1G  0 part  /boot/efi
      ├─sda2                      8:2    0    2G  0 part  /boot
      └─sda3                      8:3    0   61G  0 part
        └─ubuntu--vg-ubuntu--lv 253:0    0 30.5G  0 lvm   /
      sdb                         8:16   0  2.5G  0 disk
      ├─sdb1                      8:17   0    2G  0 part
      │ └─md1                     9:1    0    2G  0 raid1
      │   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
      └─sdb2                      8:18   0  511M  0 part
        └─md0                     9:0    0 1018M  0 raid0
      sdc                         8:32   0  2.5G  0 disk
      ├─sdc1                      8:33   0    2G  0 part
      │ └─md1                     9:1    0    2G  0 raid1
      │   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
      └─sdc2                      8:34   0  511M  0 part
        └─md0                     9:0    0 1018M  0 raid0
      sr0                        11:0    1 1024M  0 rom
      ```

17. Сделайте --fail на устройство в вашем RAID1 md.

      Решение:

      ```sh
      vagrant@sysadm-fs:~$ sudo mdadm /dev/md1 --fail /dev/sdb1
      mdadm: set /dev/sdb1 faulty in /dev/md1
      vagrant@sysadm-fs:~$ sudo mdadm -D /dev/md1
      /dev/md1:
                 Version : 1.2
           Creation Time : Mon Apr  3 15:11:09 2023
              Raid Level : raid1
              Array Size : 2094080 (2045.00 MiB 2144.34 MB)
           Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
            Raid Devices : 2
           Total Devices : 2
             Persistence : Superblock is persistent
      
             Update Time : Mon Apr  3 15:54:32 2023
                   State : clean, degraded
          Active Devices : 1
         Working Devices : 1
          Failed Devices : 1
           Spare Devices : 0
      
      Consistency Policy : resync
      
                    Name : sysadm-fs:1  (local to host sysadm-fs)
                    UUID : afab1bd0:8ee8b4f5:15b55644:6e2dd152
                  Events : 19
      
          Number   Major   Minor   RaidDevice State
             -       0        0        0      removed
             1       8       33        1      active sync   /dev/sdc1
      
             0       8       17        -      faulty   /dev/sdb1
      ```

18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

      Решение:

      ![03-sysadmin-05-fs_07.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_07.jpg?raw=true)

19. Протестируйте целостность файла — он должен быть доступен несмотря на «сбойный» диск:

      ![03-sysadmin-05-fs_08.jpg](https://github.com/notfounder/devops-netology/blob/main/img/03-sysadmin-05-fs_08.jpg?raw=true)

20. Готово - RIP VM

      ```
      notfounder@mb-grogu13 vm-parallels % vagrant destroy
          default: Are you sure you want to destroy the 'default' VM? [y/N] y
      ==> default: Forcing shutdown of VM...
      ==> default: Destroying VM and associated drives...
      ==> default: Destroying unused networking interface...
      notfounder@mb-grogu13 vm-parallels %
      ```

      
