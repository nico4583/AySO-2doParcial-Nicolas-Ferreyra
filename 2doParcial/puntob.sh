ip address show
cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIcslGI5AePS0hKngvqkjfgiQQZsCzNv3IwkWBa3b84qQ5yb/1YX/q/rgTel/6+h7/43cfK9fYBwhDg9GpfNOK5oXMpTe+bVw/J8VgM0pRTB1Xg28yOTtw1Y4RJNT499VnoYozF9LaSMVvcJG7abeAWujs6au9ALd0tTw7GUoDZ7YbBnoWxHxkr1UsNrjB5ThsQxYoGvNgjbvITUmBAFWpJNmLdDnqAVFB6DrnopB3AC6K+FcnxsZGbVkYgIywj4hS5wTx1mVp/rokTpfSAsBGvU20MC1CfVa3KxSUyn9WF+YMN1deBTxMQLpoDedl43kr+h/9/N+tBqH5J4I7cK6T vagrant@ManagementNode
ll
vim .ssh/authorized_keys
ip address show
ssh vagrant@192.168.56.9
git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
ls 
cd UTN-FRA_SO_Ansible/
cd ejemplo_02
vim inventory
[testing]

[desarrollo]
192.168.56.9

[produccion]

vim playbook.yml

---
- hosts:
    - all
  tasks:
    - name: "Set WEB_SERVICE dependiendo de la distro"
      set_fact:
        WEB_SERVICE: "{% if   ansible_facts['os_family']  == 'Debian' %}apache2
                      {% elif ansible_facts['os_family'] == 'RedHat'  %}httpd
                      {% endif %}"

    - name: "Muestro nombre del servicio:"
      debug:
        msg: "nombre: {{ WEB_SERVICE }}"

    - name: "Run the equivalent of 'apt update' as a separate step"
      become: yes
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_facts['os_family'] == "Debian"

    - name: "Instalando apache "
      become: yes
      package:
        name: "{{ item }}"
        state: present
      with_items:
        - "{{ WEB_SERVICE }}"

ansible-playbook -i inventory playbook.yml
ssh vagrant@192.168.56.2
sudo apt list --installed |grep apache
