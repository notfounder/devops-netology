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

9. 
