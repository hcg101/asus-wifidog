SRC_NAME=libwebsockets-2.0.3

all: config_test
	$(MAKE) -C $(SRC_NAME)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	cmake \
	-DCMAKE_INSTALL_PREFIX=$(STAGEDIR) \
	-DCMAKE_TOOLCHAIN_FILE=../cross-mipsel-linux.cmake \
	. \
	)

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) clean ; \
	fi ; \
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME) install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libwebsockets.so* $(ROMFSDIR)/lib
