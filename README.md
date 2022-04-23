# 2.1. Системы контроля версий.

## Задание №1

`**/.terraform/*`

Каталог с названием .terraform будет исключен в любом месте каталога terraform на любом уровне вложенности с всеми файлами в нем

`*.tfstate  `
`*.tfstate.*`

Будут исключены все файлы с раширение .tfstate в любом месте каталога terraform на любом уровне, и все файлы с названием в которых есть .tfstate. Пример: abc.tfstate; abc.tfstate.def; c.tfstate.def; etc.

`crash.log`
`crash.*.log`

Будут исключены все файлы расположенные в каталоге terraform и вложенных каталогах с именем crash.log

`*.tfvars`
`*.tfvars.json`

Будут исключены все файлы расположенные в каталоге terraform и вложенных каталогах с расширением .tfvars

`override.tf`
`override.tf.json`
`*_override.tf`
`*_override.tf.json`

Будут исключены файлы override.tf и override.tf.json расположенные в каталоге terraform и вложенных каталогах и файлы которые заканчиваются на _override.tf _override.tf.json. Пример: abc_override.tf; cdf_override.tf.json; ab_override.tf.json

`# !example_override.tf`

Если раскомментировать следующую строчку, то файл example_override.tf не будет исключаться в каталоге terraform и вложенных каталогах

`# example: *tfplan*`

Если раскомментировать следующую строчку, то все файлы с названием в которых есть tfplan в каталоге terraform и вложенных каталогах будут исключаться

`.terraformrc`
`terraform.rc`

Будут исключены все файлы terraform.rc и файлы с раширением .terraformrc расположенные в каталоге terraform и вложенных каталогах
