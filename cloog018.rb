require "formula"

class Cloog018 < Formula
  homepage "http://www.cloog.org/"
  # Track gcc infrastructure releases.
  url "http://www.bastoul.net/cloog/pages/download/cloog-0.18.1.tar.gz"
  mirror "ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz"
  sha1 "2dc70313e8e2c6610b856d627bce9c9c3f848077"

  bottle do
    sha1 "cf10ded3221cd5dae2c2980f6635da02716f62f4" => :tiger_g3
    sha1 "c8d8b01d1ae10e786b6999720c8054cb5de7a033" => :tiger_altivec
    sha1 "b9cbf9174d588eaf1a6020c7ad66398b252c197d" => :leopard_g3
    sha1 "2f8758bad04c058f2416d61c9cd87cafe94c27ea" => :leopard_altivec
  end

  keg_only "Conflicts with cloog in main repository."

  depends_on "pkg-config" => :build
  depends_on "gmp4"
  depends_on "isl012"

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--with-gmp-prefix=#{Formula["gmp4"].opt_prefix}",
      "--with-isl-prefix=#{Formula["isl012"].opt_prefix}"
    ]

    system "./configure", *args
    system "make install"
  end

  test do
    cloog_source = <<-EOS.undent
      c

      0 2
      0

      1

      1
      0 2
      0 0 0
      0

      0
    EOS

    require "open3"
    Open3.popen3("#{bin}/cloog", "/dev/stdin") do |stdin, stdout, _|
      stdin.write(cloog_source)
      stdin.close
      assert_match /Generated from \/dev\/stdin by CLooG/, stdout.read
    end
  end
end
