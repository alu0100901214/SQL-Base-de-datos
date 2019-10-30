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

        //direccion del socket remoto

        sockaddr_in remote{};
        remote.sin_family = AF_INET;
        remote.sin_port = htons(0);
        inet_aton("85.155.82.75",&remote.sin_addr);

        std::string message_text("Hola mundo");
        Message message;
        message_text.copy(message.text, sizeof(message.text) - 1, 0);

        result = sendto(fd,&message,sizeof(message),0,reinterpret_cast<const sockaddr*>(&remote),sizeof(remote));

        if( result < 0){
        std::cerr << "fallo sendto: " << std::endl;
                return 6;
        }



}
