1. Создайте аккаунт на https://bitlaunch.io/ (используйте "чистый" аддрес електронной почты)
2. Выберите Add Funds > 20$ > Make payment > Bitcoin. 
* Для платежа биткоином используйте монеты прошедшие через миксер (Wasabe, Sparrow, Samurai и тд)
* Если нет возможности - сделайте скриншот страницы и отправьте админу
3. После подтверждения платежа выберите следующие параметры для "Create Server" 
* "Host" -> "BitLaunch"
* "Instance" -> "Ubuntu 20.04 LTS"
* "Region" -> любой кроме США
* Size -> 2GB/2CPU 20$/no
 * Настоятельно рекомендую использовать SSH вместо пароля, для этого используйте следующий гайд https://bitlaunch.io/blog/creating-an-ssh-key/ 
 * Если не получается - искользуйте пароль 
4. В списке серверов скопируйте строку которая начинается "ssh root@...." 
  * Если был использован ssh добавьте следующий текст в `~/.ssh/config`
  ```
  Host bitlaunch_1
    User root
    Hostname <ip address of your server (ie 127.0.0.1 for ssh)>
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile <path to your ssh key (~/.ssh/key)>
  ```
  * В терминале введите `ssh bitlaunch_1`
  * Если использовался пароль вставьте скопированну строку в терминал
5. Используйтк этот гайд для продолжения https://github.com/rxitech/k6clean/blob/master/MHDDoS.md

