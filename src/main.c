/*
 * Copyright (c) 2012 James Deery
 * Released under the MIT license <http://opensource.org/licenses/MIT>.
 * See COPYING for details.
 */

#include <SDL2/SDL.h>

#include "alice/host.h"
#include "albase/script.h"

int main(int argc, char *argv[])
{
	BEGIN()

	AlHost *host = NULL;

	TRY(al_host_systems_init());
	TRY(al_host_init(&host));
	TRY(al_host_run_script(host, "demo.lua"));

	al_host_run(host);

	PASS(
		al_host_free(host);
		al_host_systems_free();
	)
}
