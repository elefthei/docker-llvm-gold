FROM debian:stretch

# apt-get optimizations from:
# https://github.com/moby/moby/issues/1458#issuecomment-22343707

RUN echo "force-unsafe-io" > \
			/etc/dpkg/dpkg.cfg.d/02apt-speedup && \
		echo "Acquire::http {No-Cache=True;};" > \
			/etc/apt/apt.conf.d/no-cache && \
		apt-get -y update && \
		apt-get -y install --no-install-recommends \
			wget gnupg2 ca-certificates dirmngr

RUN	echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main" > \
			/etc/apt/sources.list.d/llvm.list && \
		echo "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch main" >> \
			/etc/apt/sources.list.d/llvm.list && \
		apt-key adv --fetch-keys https://apt.llvm.org/llvm-snapshot.gpg.key && \
		apt-get -y update && \
		apt-get -y upgrade && \
		apt-get -y install --no-install-recommends \
			make cmake git bash \
			binutils-gold clang \
			llvm-runtime lld 

CMD [ "/bin/bash" ]
