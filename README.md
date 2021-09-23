# Born2beRoot
## _A system administration exercise._

## Objetivos de aprendizagem 

- Criar uma máquina virtual utilizando um hypervisor tipo 2
- Configurar um sistema operacional (linux) com algumas restrições

A [máquina virtual], ou VM, é um ambiente virtual que funciona como um sistema de computação com sua própria CPU, memória, interface de rede e armazenamento. Esse sistema virtual é criado a partir de um sistema de hardware físico.<br>
Uma máquina virtual  é definida como “uma duplicata eficiente e isolada de uma máquina real”. Em uma máquina real, uma camada de software de baixo nível (por exemplo, a BIOS dos sistemas PC) fornece acesso aos vários recursos do hardware para o sistema operacional, que os disponibiliza de forma abstrata às aplicações.<br>
Um software chamado de [hypervisor] separa do hardware os recursos utilizados pela máquina virtual e os provisiona adequadamente. 

> Um exemplo de de hypervisor popular é o [VirtualBox]. Este software cuida de alocar partes de sua CPU, RAM, armazenamento e outros componentes para que uma máquina virtual possa usá-las.

> O hipervisor tipo 2 nada mais é do que um programa (mais especificamente um ambiente de virtualização) que roda no sistema instalado no hardware como se fosse um processo deste SO e permite a criação de máquinas virtuais, onde poderão ser instaladas várias instâncias de sistemas virtualizados. Neste caso o sistema operacional que recebe o hipervisor tipo 2 é chamado de sistema operacional hospedeiro, enquanto aquele que é instalado nas máquinas virtuais é chamado de sistema hóspede [(ALVES, 2010)].
<br>
O sistema escolhido para execução deste exercicio, foi o [Debian] 11 stable,
e o hypervisor utilizado foi o [VirtualBox].


## Partições

Para visualizar a tabela de partições utilize o comando:

```
    lsblk
```

Utilizando o LVM foi criado a seguinte tabela de partições.
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
```
    deb http://ftp.debian.org/debian stable main contrib non-free
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
```
    apt install aptitude
```

[Aptitude]:<https://pt.linux-console.net/?p=1375>
[(Linux Console, 2021)]:<https://pt.linux-console.net/?p=1375>
[Debian]:<https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/>
[VirtualBox]:<https://www.virtualbox.org/>
[(ALVES, 2010)]: <https://www.gta.ufrj.br/ensino/eel879/trabalhos_vf_2010_2/luizaugusto/index.htm>
[VirtualBox]: <https://www.makeuseof.com/tag/reasons-start-using-virtual-machine/>
[hypervisor]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-hypervisor>
[máquina virtual]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-virtual-machine>
