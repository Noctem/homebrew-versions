require "formula"

class Isl012 < Formula
  homepage "http://freecode.com/projects/isl"
  # Note: Always use tarball instead of git tag for stable version.
  #
  # Currently isl detects its version using source code directory name
  # and update isl_version() function accordingly.  All other names will
  # result in isl_version() function returning "UNKNOWN" and hence break
  # package detection.
  url "http://isl.gforge.inria.fr/isl-0.12.2.tar.bz2"
  mirror "ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.12.2.tar.bz2"
  sha1 "ca98a91e35fb3ded10d080342065919764d6f928"

  bottle do
    cellar :any
    sha1 "2d878327e26853c0f17004787233ddee9060f788" => :mavericks
    sha1 "42550979c1911f818a4a124b263be08cc094bcdf" => :mountain_lion
    sha1 "08c5044ae3bbaf9e6cf5d6329addf886430696bb" => :lion
  end

  keg_only "Conflicts with isl in main repository."

  depends_on "gmp4"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-gmp=system",
                          "--with-gmp-prefix=#{Formula["gmp4"].opt_prefix}"
    system "make"
    system "make", "install"
    (share/"gdb/auto-load").install Dir["#{lib}/*-gdb.py"]
  end
end
