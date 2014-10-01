require "formula"

class Perl520 < Formula
  homepage "https://www.perl.org/"
  url "http://www.cpan.org/src/5.0/perl-5.20.1.tar.gz"
  sha1 "dad920583cab07e96bb8860a70eebc5fa9cf8e4d"

  keg_only "System provides Perl. Also conflicts with other Perl versions."

  option "use-dtrace", "Build with DTrace probes"

  def install
    args = [
      "-des",
      "-Dprefix=#{prefix}",
      "-Dman1dir=#{man1}",
      "-Dman3dir=#{man3}",
      "-Duseshrplib",
      "-Duselargefiles",
      "-Dusethreads"
    ]

    args << "-Dusedtrace" if build.include? "use-dtrace"

    system "./Configure", *args
    system "make"
    system "make test"
    system "make install"
  end
end
