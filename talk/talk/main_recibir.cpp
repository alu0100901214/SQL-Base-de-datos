/*
#include <iostream>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>

sockaddr_in remote_address{};
socklen_t scr_len = sizeof(remote_address);

struct Message{
    char text[1024];
};



int main(int argc, char *argv[])
{
    std::cout << "hola";

        int fd = socket(AF_INET,SOCK_DGRAM,0);

        if (fd < 0){
        std::cerr << "no se pudo crear el socket:" << std::endl;
        return 3;
        }

        sockaddr_in local{};
        local.sin_family = AF_INET;
        local.sin_addr.s_addr = htonl(INADDR_ANY);
        local.sin_port = htons(0);

        int result = bind(fd,reinterpret_cast<const sockaddr*> (&local),sizeof(local));

        if(result < 0){
        std::cerr << "fallo bind:" << std::endl;
        }


    Message message;

    result = recvfrom(fd, &message, sizeof(message), 0, reinterpret_cast<sockaddr*>(&remote_address), &scr_len);

    if (result < 0){
    std::cerr << "falló recvfrom: " << std::endl;
    return 9;
    }


    char* remote_ip = inet_ntoa(remote_address.sin_addr);
    int remote_port = ntohs(remote_address.sin_port);

    std::cout << "El sistema " << remote_ip << ":" << remote_port << " envió el mensaje " << message.text << std::endl;



    return 0;
}
*/
