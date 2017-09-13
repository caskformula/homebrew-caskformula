class Inkscape < Formula
  desc "Professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://launchpad.net/inkscape/0.92.x/0.92.2/+download/inkscape-0.92.2.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/i/inkscape/inkscape_0.92.2.orig.tar.bz2"
  sha256 "a628d0e04c254e9840947e6d866974f92c68ae31631a38b94d9b65e5cd84cfd3"
  revision 1

  head do
    url "https://gitlab.com/inkscape/inkscape.git", :using => :git
    url "https://gitlab.com/inkscape/inkscape.git", :using => :git, :branch => "0.92.x" if build.include? "branch-0.92"
  end

  stable do
    patch do
      url "https://gitlab.com/inkscape/inkscape/commit/93ccf03162cd2e46d962822d5507865f3451168c.diff"
      sha256 "1f037cc29cee8e0c60ab4753d4151741c8170e4849129bac68fdc60925eb971d"
    end
  end

  option "branch-0.92", "When used with --HEAD, build from the 0.92.x branch"

  option "with-gtk3", "Build Inkscape with GTK+3 (Experimental)"

  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "hicolor-icon-theme"
  depends_on "libsoup" # > 0.92.x
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"
  depends_on "poppler"
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

    system "mkdir", "build"
    Dir.chdir("build")
    system "cmake", "..", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
