# Born2beRoot

## _A system administration exercise._

## Objetivos de aprendizagem 

- Criar uma máquina virtual utilizando um hypervisor tipo 2
- Configurar um sistema operacional (linux) com algumas restrições
<hr>
A [máquina virtual], ou VM, é um ambiente virtual que funciona como um sistema de computação com sua própria CPU, memória, interface de rede e armazenamento. Esse sistema virtual é criado a partir de um sistema de hardware físico.<br>
Uma máquina virtual  é definida como “uma duplicata eficiente e isolada de uma máquina real”. Em uma máquina real, uma camada de software de baixo nível (por exemplo, a BIOS dos sistemas PC) fornece acesso aos vários recursos do hardware para o sistema operacional, que os disponibiliza de forma abstrata às aplicações.<br>
Um software chamado de [hypervisor] separa do hardware os recursos utilizados pela máquina virtual e os provisiona adequadamente. 

> Um exemplo de de hypervisor popular é o [VirtualBox]. Este software cuida de alocar partes de sua CPU, RAM, armazenamento e outros componentes para que uma máquina virtual possa usá-las.

> O hipervisor tipo 2 nada mais é do que um programa (mais especificamente um ambiente de virtualização) que roda no sistema instalado no hardware como se fosse um processo deste SO e permite a criação de máquinas virtuais, onde poderão ser instaladas várias instâncias de sistemas virtualizados. Neste caso o sistema operacional que recebe o hipervisor tipo 2 é chamado de sistema operacional hospedeiro, enquanto aquele que é instalado nas máquinas virtuais é chamado de sistema hóspede [(ALVES, 2010)].
<br>
O sistema escolhido para execução deste exercicio, foi o [Debian] 11 stable,
e o hypervisor utilizado foi o [VirtualBox].

## Comandos Uteis

#### Usuários e Grupos
```shell
adduser <username> #Adicionar usuario
usermod -aG <groupname> <username> #Adicionar usuario a um grupo
groups <username> #Verificar grupos de determinado usuario
groupadd <groupname> #addicionar novogrupo
hostnamectl status #mostrar o hostname
hostnamectl set-hostname <new-hostname> #mudar senha
passwd <username> #Trocar senha
```


## Partições

Para visualizar a tabela de partições utilize o comando:

```shell
    lsblk
```

Utilizando o LVM foi criado a seguinte estrutura de partições.
```
NAME                    MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                       8:0    0 30.8G  0 disk  
├─sda1                    8:1    0  476M  0 part  /boot
├─sda2                    8:2    0    1K  0 part  
└─sda5                    8:5    0 30.3G  0 part  
  └─sda5_crypt          254:0    0 30.3G  0 crypt 
    ├─LVMGroup-root     254:1    0  9.3G  0 lvm   /
    ├─LVMGroup-swap     254:2    0  2.2G  0 lvm   [SWAP]
    ├─LVMGroup-home     254:3    0  4.8G  0 lvm   /home
    ├─LVMGroup-var      254:4    0  2.9G  0 lvm   /var
    ├─LVMGroup-srv      254:5    0  2.9G  0 lvm   /srv
    ├─LVMGroup-tmp      254:6    0  2.9G  0 lvm   /tmp
    └─LVMGroup-var--log 254:7    0  5.5G  0 lvm   /var/log
```
## Gerenciador de Pacotes
As operações de gestão de pacotes baseadas em repositório no sistema Debian podem ser executas por muitas ferramentas de gestão de pacotes baseadas no APT e disponíveis no sistema Debian. 
Para as operações de gestão de pacotes que envolvam a instalação ou atualização de meta-dados do pacote, necessita de ter privilégios de root.

Para este projeto a lista de pacotes abaixo foi adicionada ao `/etc/apt/sources.list`.
```shell
    deb http://ftp.debian.org/debian stable main contrib non-free
```
## Configurar ip estático

Com a placa de rede configurada como "bridge" no hypervisor execute o seguinte commando para desabilitar o dhcp e manter o ip como estático. 

Comando para instalar o `net-tools`
```
    apt install net-tools
```
Após instalar o net-tools adicione as linhas abaixo ao arquivo `/etc/network/interfaces`.
```
*exemplo utilizando a minha rede local!

    iface ... inet static
    address "192.168.1.102"
    gateway "192.168.1.1"
    netmask "255.255.255.0"
```

### Apt
Apt ou Advanced Packaging Tool é um software de código aberto e gratuito que lida com a instalação e remoção de software.<br>
Sempre que invocado a partir da linha de comando junto com a especificação do nome do pacote a ser instalado, ele encontra esse pacote na lista configurada de fontes especificadas em '/etc/apt/sources.list' junto com a lista de dependências para aquele pacote e os classifica e os instala automaticamente junto com o pacote atual, permitindo que o usuário não se preocupe em instalar dependências.
É altamente flexível, permitindo ao usuário controlar várias configurações facilmente, como: adicionar qualquer nova fonte para pesquisar pacotes, apt-pinning, ou seja, marcar qualquer pacote indisponível durante a atualização do sistema, tornando assim sua versão atual a sua versão final instalada, "inteligente" atualizar, ou seja, atualizar os pacotes mais importantes e deixar os menos importantes [(Linux Console, 2021)].

### Aptitude
[Aptitude] é um front-end criado pela equipe do Debian, para uma ferramenta de empacotamento avançada que adiciona uma interface de usuário à funcionalidade, permitindo ao usuário pesquisar interativamente por um pacote e instalá-lo ou removê-lo.
Além da principal diferença ser que o Aptitude é um gerenciador de pacotes de alto nível, enquanto o APT é um gerenciador de pacotes de nível inferior que pode ser usado por outros gerenciadores de pacotes de nível superior.
A diferença mais óbvia é que aptitudefornece uma interface de menu de terminal (semelhante ao Synaptic em um terminal), enquanto apt não fornece.

Para instalar o aptitude utilize o comando:
```shell
    apt install aptitude
```
## AppArmor
[AppArmor] é um sistema de Controle de Acesso Mandatório (MAC - Mandatory Access Control) construído sobre a interface LSM (Linux Security Modules) do Linux. Na prática, o kernel consulta o AppArmor antes de cada chamada do sistema para saber se o processo está autorizado a fazer a operação dada. Através desse mecanismo, o AppArmor confina programas a um conjunto limitado de recursos. 
É semelhante ao SELinux, usado por padrão no Fedora e no Red Hat. Embora funcionem de forma diferente, o AppArmor e o SELinux fornecem segurança de “controle de acesso obrigatório” (MAC). Na verdade, o AppArmor permite que os desenvolvedores do Debian restrinjam as ações que os processos podem realizar. 

Para instalar o AppArmor utilize o comando:
```shell
    aptitude install apparmor
```
Para habilitar o AppArmor utilize o comando:
```shell
    aa-status 
    systemctl enable apparmor
```

## UFW (Uncomplicated Firewall)
Para instalar e habilitar o ufw utilize os comandos:
```shell
    aptitude install ufw
    systemctl enable ufw
```

O UFW, ou Uncomplicated Firewall, é uma interface de gerenciamento simplificado de firewall que esconde a complexidade das tecnologias de filtragem de pacotes de baixo nível, como iptables e nftables.

Para adicionar uma nova porta utilize o comando:
```shell
    ufw allow "porta"
    systemctl enable ufw
```
Para habilitar o ufw ao iniciar o sistema:
```shell
    systemctl enable ufw
```

## SSH (Secure Socket Shell)
O SSH é um protocolo que garante que cliente e servidor remoto troquem informações de maneira segura e dinâmica. O processo é capaz de criptografar os arquivos enviados ao diretório do servidor, garantindo que alterações e o envio de dados sejam realizados da melhor forma.<br>
O protocolo [SSH] é um dos parâmetros de trabalho que garantem que as informações estarão **devidamente protegidas**.
SSH é uma sigla, ou acrônimo, para o termo secure shell, que significa cápsula segura. Na prática, o protocolo SSH é um mecanismo de segurança oferecido pelos serviços de hospedagem.<br>
A função dele é garantir que haja uma conexão segura entre o computador e o servidor remoto, o que garante a transferência de dados sem nenhuma perda de informação.<br>
O SSH tem a função de permitir aos usuários e desenvolvedores realizarem qualquer modificação em sites e servidores utilizando uma conexão simples.<br>
Para instalar o ssh utilize os comandos:
```shell
    aptitude install openssh-server 
    aptitude install openssh-client
    systemctl start sshd
    systemctl enable sshd
```
Para configuração do ssh adicione as linhas abaixo ao arquivo `/etc/ssh/sshd_config`.
```shell
    Port 4242
    PermitRootLogin no
```
Após editar o arquivo execute `systemctl restart sshd` para atualizar as configurações do ssh.

Para conectar a VM utilizando o ssh execute o comando abaixo utilizando suas configurações de rede e usuário.

No meu caso o comando foi:
```shell
    ssh anhigo-s@192.168.1.100 -p 4242
```
## Sudo

Este comando permite executar um comando como se fosse o superusuário (root) ou um outro usuário.<br>
Algumas opções do [comando]:

   - -h  exibe as opções do comando.
   - -l  lista os comandos permitidos (e os comandos proibidos) para o usuário no ambiente de trabalho atual.
   - -u usuário : o sudo executa o comando com os privilégios do usuário especificado.
  - -V : fornece informações sobre o comando.
    

No debian o sudo não vêm instalado no sistema, para instalar execute o comando abaixo:
```shell
    aptitude install sudo
```
Após a instalação execute os comandos abaixo para criar a pasta onde serão armazenados os arquivos e diretórios de log e o softlink necessário para executar o [sudoreplay].
```shell
    mkdir /var/log/sudo
    ln -s /var/log/sudo /var/log/sudo-io
```
Para configurar o sudo conforme os parâmetros do exercício, execute o comando `visudo` e adicione as linhas abaixo ao arquivo.
```shell
    Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
    Defaults	requiretty
    Defaults	passwd_tries=3
    Defaults	badpass_message="Bad password, You shall no pass"
    Defaults	logfile=/var/log/sudo/sudo.log
    Defaults	log_input, log_output
    Defaults	log_year
    Defaults	iolog_dir=/var/log/sudo
```
## Política de senhas

[Política de senhas] corporativas envolve regras que devem ser seguidas por todos os usuários, além de garantir que uma equipe seja responsável por realizar o monitoramento de todos os acessos. <br>
Ela ainda visa assegurar que critérios mínimos de segurança durante o acesso aos sistemas e dispositivos corporativos sejam seguidos.<br>

Neste exercício a politica de senha foi:

- Expirar a cada 30 dias
- Número mínimo de 2 dias para alterar a senha.
- O usuário recebe uma mensagem de aviso 7 dias antes de sua senha expirar.
- A senha deve conter pelo menos 10 caracteres. A senha deve ter pelo menos uma letra maiúscula e um número.
- Não pode ter 3 caracteres consecutivos iguais.
- A senha não pode incluir o nome do usuário.
- Deve ter pelo menos 7 caracteres que não fazem parte da senha anterior (não se aplica ao root *difok).

Adicionar as seguintes linhas no arquivo `/etc/login.defs`.
```
    PASS_MAX_DAYS   30
    PASS_MIN_DAYS   2
    PASS_WARN_AGE   7
    LOGIN_RETRIES   3
```
Adicionar as seguintes linhas no arquivo `etc/security/pwquality.conf`.
```
    difok = 7
    minlen = 10
    dcredit = -1
    ucredit = -1
    maxrepeat = 3
    usercheck = 1
    retry = 3
    enforce_for_root
```


[política de senhas]:<https://digital.br.synnex.com/pt/8-melhores-praticas-para-uma-politica-de-senhas-eficaz>
[sudoreplay]:<https://www.sudo.ws/man/1.8.13/sudoreplay.man.html>
[comando]:<https://guialinux.uniriotec.br/sudo/>
[SSH]:<https://rockcontent.com/br/blog/ssh/>
[AppArmor]:<https://www.thefastcode.com/pt-eur/article/what-is-apparmor-and-how-does-it-keep-ubuntu-secure?>
[Aptitude]:<https://pt.linux-console.net/?p=1375>
[(Linux Console, 2021)]:<https://pt.linux-console.net/?p=1375>
[Debian]:<https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/>
[VirtualBox]:<https://www.virtualbox.org/>
[(ALVES, 2010)]: <https://www.gta.ufrj.br/ensino/eel879/trabalhos_vf_2010_2/luizaugusto/index.htm>
[VirtualBox]: <https://www.makeuseof.com/tag/reasons-start-using-virtual-machine/>
[hypervisor]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-hypervisor>
[máquina virtual]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-virtual-machine>
