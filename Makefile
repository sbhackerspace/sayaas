.PHONY: install dist distdir clean distclean install uninstall load unload reload

distdir = sayaas-$(shell grep __version__\ = sayaas | cut -d\' -f2)

install:
	install -p -m 0755 sayaas $(DESTDIR)/usr/local/bin/sayaas
	install -p -m 0644 com.sbhackerspace.sayaas.plist $(DESTDIR)/Library/LaunchDaemons/com.sbhackerspace.sayaas.plist

uninstall: unload
	rm -f $(DESTDIR)/usr/local/bin/sayaas
	rm -f $(DESTDIR)/Library/LaunchDaemons/com.sbhackerspace.sayaas.plist

load:
	launchctl load -w /Library/LaunchDaemons/com.sbhackerspace.sayaas.plist

unload:
	launchctl unload /Library/LaunchDaemons/com.sbhackerspace.sayaas.plist

reload: unload load

distdir: sayaas com.sbhackerspace.sayaas.plist Makefile COPYING README
	rm -rf $(distdir)
	mkdir -p $(distdir)
	cp -pR $^ $(distdir)

dist: distdir
	mkdir -p dist
	COPYFILE_DISABLE=true tar -cJ -f dist/$(distdir).tar.xz $(distdir)
	rm -rf $(distdir)

clean:
	rm -rf dist

distclean: clean
