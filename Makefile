include Makefile.inc

DIRMAN = man

DIRSCRIPTS = scripts

.PHONY: all


all:
	$(MAKE) -C $(DIRSCRIPTS) all
	$(MAKE) -C $(DIRMAN) all

install: all

	$(MAKE) -C $(DIRSCRIPTS) install
	$(MAKE) -C $(DIRMAN) install
man:
	$(MAKE) -C $(DIRMAN) man
clean:

	$(MAKE) -C $(DIRSCRIPTS) clean
	$(MAKE) -C $(DIRMAN) clean

dist: distclean

	git archive --format=tar --prefix=$(NAME)/ HEAD | tar -x
	git log > $(NAME)/ChangeLog
	tar cJvf $(NAME).tar.xz $(NAME)
	rm -rf $(NAME)
	sed -i "/nutyx-/d" scripts/wget_yaolinux_list
	md5sum $(NAME).tar.xz >> scripts/wget_yaolinux_list

distclean:
	rm -rf $(NAME).tar.xz
