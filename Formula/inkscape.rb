class Inkscape < Formula
  desc "Professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://inkscape.org/gallery/item/10552/inkscape-0.92.0.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/i/inkscape/inkscape_0.92.0.orig.tar.bz2"
  sha256 "b8b4c159a00448d465384533e5a70d3f33e5f9c6b74c76ea5d636ddd6dd7ba56"
  revision 1

  head do
    url "lp:inkscape", :using => :bzr
    url "lp:inkscape/0.92.x", :using => :bzr if build.include? "branch-0.92"
  end

  option "branch-0.92", "When used with --HEAD, build from the 0.92.x branch"

  option "with-gtk3", "Build Inkscape with GTK+3 (Experimental)"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "poppler" => :optional
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "hicolor-icon-theme"
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"
  depends_on "potrace"

  depends_on "gtkmm3" if build.with? "gtk3"
  depends_on "gdl" if build.with? "gtk3"
  depends_on "gtkmm" if build.without? "gtk3"

  needs :cxx11

  if MacOS.version < :mavericks
    fails_with :clang do
      cause "inkscape's dependencies will be built with libstdc++ and fail to link."
    end
  end

  def install
    ENV.cxx11
    ENV.append "LDFLAGS", "-liconv"

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-strict-build
      --enable-lcms
      --without-gnome-vfs
    ]
    args << "--disable-poppler-cairo" if build.without? "poppler"
    args << "--enable-gtk3-experimental" if build.with? "gtk3"

    system "./autogen.sh"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
