
#include "stomp.h"

#ifdef __cplusplus
extern "C"
{
#endif

%%{
	machine stomp_server_fsm;
    include stomp_fsm "stomp.rl";
	access stomp->;

	
	main := SERVER_STREAM;

}%%

%% write data;




void stomp_server_init(stomp_t *stomp) {

	STOMP_INIT(stomp);

	%% write init;
}

void stomp_server_execute(stomp_t *stomp, const char *data, int len, int isEof) {
	const char *p = data;
	const char *pe = data + len;
	const char *eof = isEof ? pe : 0;

	%% write exec;
}

int stomp_server_finish(stomp_t *stomp) {
	if ( stomp->cs == stomp_server_fsm_error ) {
		return -1;
	}
	if ( stomp->cs >= stomp_server_fsm_first_final ) {
		return 1;
	}
	return 0;
}

#ifdef __cplusplus
}
#endif