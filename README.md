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


[(ALVES, 2010)]: <https://www.gta.ufrj.br/ensino/eel879/trabalhos_vf_2010_2/luizaugusto/index.htm>
[hypervisor]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-hypervisor>
[VirtualBox]: <https://www.makeuseof.com/tag/reasons-start-using-virtual-machine/>
[máquina virtual]: <https://www.redhat.com/pt-br/topics/virtualization/what-is-a-virtual-machine>
