include ./config.mk

.PHONY : really clean install

MOSQ_OBJS=mosquitto.o \
		  actions.o \
		  callbacks.o \
		  connect.o \
		  handle_connack.o \
		  handle_ping.o \
		  handle_pubackcomp.o \
		  handle_publish.o \
		  handle_pubrec.o \
		  handle_pubrel.o \
		  handle_suback.o \
		  handle_unsuback.o \
		  helpers.o \
		  logging_mosq.o \
		  loop.o \
		  memory_mosq.o \
		  messages_mosq.o \
		  net_mosq.o \
		  options.o \
		  packet_mosq.o \
		  read_handle.o \
		  send_connect.o \
		  send_disconnect.o \
		  send_mosq.o \
		  send_publish.o \
		  send_subscribe.o \
		  send_unsubscribe.o \
		  socks_mosq.o \
		  srv_mosq.o \
		  thread_mosq.o \
		  time_mosq.o \
		  tls_mosq.o \
		  utf8_mosq.o \
		  util_mosq.o \
		  will_mosq.o

ALL_DEPS:=

ifeq ($(WITH_SHARED_LIBRARIES),yes)
	ALL_DEPS+=libmosquitto.so.${SOVERSION}
endif

ifeq ($(WITH_STATIC_LIBRARIES),yes)
	ALL_DEPS+=libmosquitto.a
endif

all : ${ALL_DEPS}
ifeq ($(WITH_SHARED_LIBRARIES),yes)
	$(MAKE) -C cpp
endif

install : all
	$(INSTALL) -d "${DESTDIR}${libdir}/"
ifeq ($(WITH_SHARED_LIBRARIES),yes)
	$(INSTALL) ${STRIP_OPTS} libmosquitto.so.${SOVERSION} "${DESTDIR}${libdir}/libmosquitto.so.${SOVERSION}"
	ln -sf libmosquitto.so.${SOVERSION} "${DESTDIR}${libdir}/libmosquitto.so"
endif
ifeq ($(WITH_STATIC_LIBRARIES),yes)
	$(INSTALL) ${STRIP_OPTS} libmosquitto.a "${DESTDIR}${libdir}/libmosquitto.a"
endif
	$(INSTALL) -d "${DESTDIR}${incdir}/"
	$(INSTALL) mosquitto.h "${DESTDIR}${incdir}/mosquitto.h"
	$(INSTALL) -d "${DESTDIR}${libdir}/pkgconfig"
	$(INSTALL) -m644 ../libmosquitto.pc.in "${DESTDIR}${libdir}/pkgconfig/libmosquitto.pc"
	sed -i -e "s#@CMAKE_INSTALL_PREFIX@#${prefix}#" -e "s#@VERSION@#${VERSION}#" "${DESTDIR}${libdir}/pkgconfig/libmosquitto.pc"
ifeq ($(WITH_SHARED_LIBRARIES),yes)
	$(MAKE) -C cpp install
endif

uninstall :
	-rm -f "${DESTDIR}${libdir}/libmosquitto.so.${SOVERSION}"
	-rm -f "${DESTDIR}${libdir}/libmosquitto.so"
	-rm -f "${DESTDIR}${libdir}/libmosquitto.a"
	-rm -f "${DESTDIR}${incdir}/mosquitto.h"

reallyclean : clean

clean :
	-rm -f *.o libmosquitto.so.${SOVERSION} libmosquitto.so libmosquitto.a
	$(MAKE) -C cpp clean

libmosquitto.so.${SOVERSION} : ${MOSQ_OBJS}
	${CROSS_COMPILE}$(CC) -shared $(LIB_LDFLAGS) $^ -o $@ ${LIB_LIBS}

libmosquitto.a : ${MOSQ_OBJS}
	${CROSS_COMPILE}$(AR) cr $@ $^

mosquitto.o : mosquitto.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

actions.o : actions.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

callbacks.o : callbacks.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

connect.o : connect.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_connack.o : handle_connack.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_publish.o : handle_publish.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_ping.o : handle_ping.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_pubackcomp.o : handle_pubackcomp.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_pubrec.o : handle_pubrec.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_pubrel.o : handle_pubrel.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_suback.o : handle_suback.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

handle_unsuback.o : handle_unsuback.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

helpers.o : helpers.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

logging_mosq.o : logging_mosq.c logging_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

loop.o : loop.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

messages_mosq.o : messages_mosq.c messages_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

memory_mosq.o : memory_mosq.c memory_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

net_mosq.o : net_mosq.c net_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

options.o : options.c mosquitto.h mosquitto_internal.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

packet_mosq.o : packet_mosq.c packet_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

read_handle.o : read_handle.c read_handle.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_connect.o : send_connect.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_disconnect.o : send_disconnect.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_mosq.o : send_mosq.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_publish.o : send_publish.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_subscribe.o : send_subscribe.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

send_unsubscribe.o : send_unsubscribe.c send_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

socks_mosq.o : socks_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

srv_mosq.o : srv_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

thread_mosq.o : thread_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

time_mosq.o : time_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

tls_mosq.o : tls_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

utf8_mosq.o : utf8_mosq.c
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

util_mosq.o : util_mosq.c util_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

will_mosq.o : will_mosq.c will_mosq.h
	${CROSS_COMPILE}$(CC) $(LIB_CFLAGS) -c $< -o $@

