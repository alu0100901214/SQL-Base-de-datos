//http://www.chuidiang.com/clinux/sockets/udp/udp.php
#include <iostream>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
struct Message{
    char text[1024];
};

int main(int argc, char *argv[])
{

        int fd = socket(AF_INET,SOCK_DGRAM,0);

        if (fd < 0){
        std::cerr << "no se pudo crear el socket:\n" << std::endl;
        return 3;
        }

        sockaddr_in local{};
        local.sin_family = AF_INET;
        local.sin_addr.s_addr = htonl(INADDR_ANY);
        local.sin_port = htons(0);

        int result = bind(fd,reinterpret_cast<const sockaddr*> (&local),sizeof(local));

        if(result < 0){
        std::cerr << "fallo bind:\n" << std::endl;
        }

        //direccion del socket remoto

        sockaddr_in remote{};
        remote.sin_family = AF_INET;
        remote.sin_port = htons(0);
        int a = inet_aton("10.209.31.255",&remote.sin_addr);
        if ( a == 0 ){
            std::cout << "fallo inet_aton:\n";
        }
        std::string message_text("Hola mundo");
        Message message;
        message_text.copy(message.text, sizeof(message.text) - 1, 0);

        int resultado = sendto(fd,&message,sizeof(message),0,reinterpret_cast<const sockaddr*>(&remote),sizeof(remote));

        if( resultado < 0){
        std::cerr << "fallo sendto: \n" << std::endl;
                return 6;
        }



}


