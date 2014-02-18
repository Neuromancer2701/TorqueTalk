#ifdef __DUETTO_CLIENT__
#include <duetto/client.h>
#else
#include <server.h>
#endif

#include <string>

#ifdef __DUETTO_CLIENT__
using namespace client;
#endif

int GetAnswerToLifeTheUniverseAndEverything() [[server]]
{
        return 42;
}

void webMain() [[client]]
{
        const std::string str("Hello Server! The answer to life, the universe and everything is ");
        int answer = GetAnswerToLifeTheUniverseAndEverything();
        console.log(str.c_str(), answer);
}
