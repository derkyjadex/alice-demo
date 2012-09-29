#include <SDL/SDL.h>

#include "alice/host.h"
#include "albase/script.h"

int main(int argc, char *argv[])
{
	BEGIN()

	AlHost *host = NULL;

	const char *scripts[] = {
		NULL
	};

	TRY(al_host_systems_init());
	TRY(al_host_init(&host));
	TRY(al_load_scripts(host->lua, scripts));

	al_host_run(host);

	PASS(
		al_host_free(host);
		al_host_systems_free();
	)
}
