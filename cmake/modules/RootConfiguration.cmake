# Copyright (C) 1995-2019, Rene Brun and Fons Rademakers.
# All rights reserved.
#
# For the licensing terms see $ROOTSYS/LICENSE.
# For the list of contributors see $ROOTSYS/README/CREDITS.

INCLUDE (CheckCXXSourceCompiles)

#---Define a function not to pollute the top level namespace with unneeded variables-----------------------
function(RootConfigure)

#---Define all sort of variables to bridge between the old Module.mk and the new CMake equivalents-----------
foreach(v 1 ON YES TRUE Y on yes true y)
  set(value${v} yes)
endforeach()
foreach(v 0 OFF NO FALSE N IGNORE off no false n ignore)
  set(value${v} no)
endforeach()

set(ROOT_DICTTYPE cint)
#set(ROOT_CONFIGARGS "")
set(top_srcdir ${CMAKE_SOURCE_DIR})
set(top_builddir ${CMAKE_BINARY_DIR})
set(architecture ${ROOT_ARCHITECTURE})
set(platform ${ROOT_PLATFORM})
set(host)
set(useconfig FALSE)
set(major ${ROOT_MAJOR_VERSION})
set(minor ${ROOT_MINOR_VERSION})
set(revis ${ROOT_PATCH_VERSION})
set(mkliboption "-v ${major} ${minor} ${revis} ")
set(cflags ${CMAKE_CXX_FLAGS})
set(ldflags ${CMAKE_CXX_LINK_FLAGS})

set(winrtdebug ${value${winrtdebug}})
set(exceptions ${value${exceptions}})

if(gnuinstall)
  set(prefix ${CMAKE_INSTALL_PREFIX})
else()
  set(prefix $(ROOTSYS))
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_SYSCONFDIR})
  set(etcdir ${CMAKE_INSTALL_SYSCONFDIR})
else()
  set(etcdir ${prefix}/${CMAKE_INSTALL_SYSCONFDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_BINDIR})
  set(bindir ${CMAKE_INSTALL_BINDIR})
else()
  set(bindir ${prefix}/${CMAKE_INSTALL_BINDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_LIBDIR})
  set(libdir ${CMAKE_INSTALL_LIBDIR})
else()
  set(libdir ${prefix}/${CMAKE_INSTALL_LIBDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_INCLUDEDIR})
  set(incdir ${CMAKE_INSTALL_INCLUDEDIR})
else()
  set(incdir ${prefix}/${CMAKE_INSTALL_INCLUDEDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_MANDIR})
  set(mandir ${CMAKE_INSTALL_MANDIR})
else()
  set(mandir ${prefix}/${CMAKE_INSTALL_MANDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_SYSCONFDIR})
  set(plugindir ${CMAKE_INSTALL_SYSCONFDIR}/plugins)
else()
  set(plugindir ${prefix}/${CMAKE_INSTALL_SYSCONFDIR}/plugins)
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_DATADIR})
  set(datadir ${CMAKE_INSTALL_DATADIR})
else()
  set(datadir ${prefix}/${CMAKE_INSTALL_DATADIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_FONTDIR})
  set(ttffontdir ${CMAKE_INSTALL_FONTDIR})
else()
  set(ttffontdir ${prefix}/${CMAKE_INSTALL_FONTDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_JSROOTDIR})
  set(jsrootdir ${CMAKE_INSTALL_JSROOTDIR})
else()
  set(jsrootdir ${prefix}/${CMAKE_INSTALL_JSROOTDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_OPENUI5DIR})
  set(openui5dir ${CMAKE_INSTALL_OPENUI5DIR})
else()
  set(openui5dir ${prefix}/${CMAKE_INSTALL_OPENUI5DIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_MACRODIR})
  set(macrodir ${CMAKE_INSTALL_MACRODIR})
else()
  set(macrodir ${prefix}/${CMAKE_INSTALL_MACRODIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_SRCDIR})
  set(srcdir ${CMAKE_INSTALL_SRCDIR})
else()
  set(srcdir ${prefix}/${CMAKE_INSTALL_SRCDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_ICONDIR})
  set(iconpath ${CMAKE_INSTALL_ICONDIR})
else()
  set(iconpath ${prefix}/${CMAKE_INSTALL_ICONDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_CINTINCDIR})
  set(cintincdir ${CMAKE_INSTALL_CINTINCDIR})
else()
  set(cintincdir ${prefix}/${CMAKE_INSTALL_CINTINCDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_DOCDIR})
  set(docdir ${CMAKE_INSTALL_DOCDIR})
else()
  set(docdir ${prefix}/${CMAKE_INSTALL_DOCDIR})
endif()
if(IS_ABSOLUTE ${CMAKE_INSTALL_TUTDIR})
  set(tutdir ${CMAKE_INSTALL_TUTDIR})
else()
  set(tutdir ${prefix}/${CMAKE_INSTALL_TUTDIR})
endif()

set(buildx11 ${value${x11}})
set(x11libdir -L${X11_LIBRARY_DIR})
set(xpmlibdir -L${X11_LIBRARY_DIR})
set(xpmlib ${X11_Xpm_LIB})

set(thread yes)
set(enable_thread yes)
set(threadflag ${CMAKE_THREAD_FLAG})
set(threadlibdir)
set(threadlib ${CMAKE_THREAD_LIBS_INIT})

set(builtinfreetype ${value${builtin_freetype}})
set(builtinpcre ${value${builtin_pcre}})

set(builtinzlib ${value${builtin_zlib}})
set(zliblibdir ${ZLIB_LIBRARY_DIR})
set(zliblib ${ZLIB_LIBRARY})
set(zlibincdir ${ZLIB_INCLUDE_DIR})

set(builtinunuran ${value${builtin_unuran}})
set(unuranlibdir ${UNURAN_LIBRARY_DIR})
set(unuranlib ${UNURAN_LIBRARY})
set(unuranincdir ${UNURAN_INCLUDE_DIR})

set(buildgl ${value${opengl}})
set(opengllibdir ${OPENGL_LIBRARY_DIR})
set(openglulib ${OPENGL_glu_LIBRARY})
set(opengllib ${OPENGL_gl_LIBRARY})
set(openglincdir ${OPENGL_INCLUDE_DIR})

set(builtingl2ps ${value${builtin_gl2ps}})
set(gl2pslibdir ${GL2PS_LIBRARY_DIR})
set(gl2pslib ${GL2PS_LIBRARY})
set(gl2psincdir ${GL2PS_INCLUDE_DIR})

set(buildsqlite ${value${sqlite}})
set(sqlitelibdir ${SQLITE_LIBRARY_DIR})
set(sqlitelib ${SQLITE_LIBRARY})
set(sqliteincdir ${SQLITE_INCLUDE_DIR})

set(builddavix ${value${davix}})
set(davixlibdir ${DAVIX_LIBRARY_DIR})
set(davixlib ${DAVIX_LIBRARY})
set(davixincdir ${DAVIX_INCLUDE_DIR})
if(davix)
  set(hasdavix define)
  set(useoldwebfile no)
else()
  set(hasdavix undef)
  set(useoldwebfile yes)
endif()

set(buildnetxng ${value${netxng}})

set(builddcap ${value${dcap}})
set(dcaplibdir ${DCAP_LIBRARY_DIR})
set(dcaplib ${DCAP_LIBRARY})
set(dcapincdir ${DCAP_INCLUDE_DIR})

set(buildftgl ${value${builtin_ftgl}})
set(ftgllibdir ${FTGL_LIBRARY_DIR})
set(ftgllibs ${FTGL_LIBRARIES})
set(ftglincdir ${FTGL_INCLUDE_DIR})

set(buildglew ${value${builtin_glew}})
set(glewlibdir ${GLEW_LIBRARY_DIR})
set(glewlibs ${GLEW_LIBRARIES})
set(glewincdir ${GLEW_INCLUDE_DIR})

set(buildarrow ${value${arrow}})
set(arrowlibdir ${ARROW_LIBRARY_DIR})
set(arrowlib ${ARROW_LIBRARY})
set(arrowincdir ${ARROW_INCLUDE_DIR})

set(buildasimage ${value${asimage}})
set(asextralib ${ASEXTRA_LIBRARIES})
set(asextralibdir)
set(asjpegincdir ${JPEG_INCLUDE_DIR})
set(aspngincdir ${PNG_INCLUDE_DIR})
set(astiffincdir ${TIFF_INCLUDE_DIR})
set(asgifincdir ${GIF_INCLUDE_DIR})
set(asimageincdir)
set(asimagelib)
set(asimagelibdir)

set(buildpythia8 ${value${pythia8}})
set(pythia8libdir ${PYTHIA8_LIBRARY_DIR})
set(pythia8lib ${PYTHIA8_LIBRARY})
set(pythia8cppflags)

set(buildfftw3 ${value${fftw3}})
set(fftw3libdir ${FFTW3_LIBRARY_DIR})
set(fftw3lib ${FFTW3_LIBRARY})
set(fftw3incdir ${FFTW3_INCLUDE_DIR})

set(buildfitsio ${value${fitsio}})
set(fitsiolibdir ${FITSIO_LIBRARY_DIR})
set(fitsiolib ${FITSIO_LIBRARY})
set(fitsioincdir ${FITSIO_INCLUDE_DIR})

set(buildgviz ${value${gviz}})
set(gvizlibdir ${GVIZ_LIBRARY_DIR})
set(gvizlib ${GVIZ_LIBRARY})
set(gvizincdir ${GVIZ_INCLUDE_DIR})
set(gvizcflags)

set(buildpython ${value${pyroot}})
set(pythonlibdir ${Python3_LIBRARY_DIR})
set(pythonlib ${Python3_LIBRARIES})
set(pythonincdir ${Python3_INCLUDE_DIRS})
set(pythonlibflags)

set(buildxml ${value${xml}})
set(xmllibdir ${LIBXML2_LIBRARY_DIR})
set(xmllib ${LIBXML2_LIBRARIES})
set(xmlincdir ${LIBXML2_INCLUDE_DIR})

set(buildxrd ${value${xrootd}})
set(xrdlibdir )
set(xrdincdir)
set(xrdaddopts)
set(extraxrdflags)
set(xrdversion)

set(alloclib)
set(alloclibdir)

set(ssllib ${OPENSSL_LIBRARIES})
set(ssllibdir)
set(sslincdir ${OPENSSL_INCLUDE_DIR})
set(sslshared)

set(gsllibs ${GSL_LIBRARIES})
set(gsllibdir)
set(gslincdir ${GSL_INCLUDE_DIR})
set(gslflags)

set(shadowpw ${value${shadowpw}})
set(buildmathmore ${value${mathmore}})
set(buildroofit ${value${roofit}})
set(buildunuran ${value${unuran}})
set(buildgdml ${value${gdml}})
set(buildhttp ${value${http}})
if(fcgi AND http)
set(usefastcgi yes)
set(fastcgiincdir ${FASTCGI_INCLUDE_DIR})
else()
set(usefastcgi no)
set(fcgiincdir)
endif()

set(buildtmva ${value${tmva}})

set(cursesincdir ${CURSES_INCLUDE_DIR})
set(curseslibdir)
set(curseslib ${CURSES_LIBRARIES})
set(curseshdr ${CURSES_HEADER_FILE})
set(buildeditline ${value${editline}})
set(cppunit)
set(dicttype ${ROOT_DICTTYPE})


find_program(PERL_EXECUTABLE perl)
set(perl ${PERL_EXECUTABLE})

find_program(CHROME_EXECUTABLE NAMES chrome.exe chromium chromium-browser chrome chrome-browser google-chrome-stable Google\ Chrome
             HINTS /snap/bin
             PATH_SUFFIXES "Google/Chrome/Application")
if(CHROME_EXECUTABLE)
  if(WIN32)
    set(chromemajor 100)
    message(STATUS "Found Chrome browser executable ${CHROME_EXECUTABLE}, not testing the version")
  else()
    execute_process(COMMAND "${CHROME_EXECUTABLE}" --version
                    OUTPUT_VARIABLE CHROME_VERSION
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(REGEX MATCH "[0-9]+" CHROME_MAJOR_VERSION "${CHROME_VERSION}")
    set(chromemajor ${CHROME_MAJOR_VERSION})
    message(STATUS "Found Chrome browser executable ${CHROME_EXECUTABLE} major version ${CHROME_MAJOR_VERSION}")
  endif()
  set(chromeexe ${CHROME_EXECUTABLE})
endif()

if(WIN32)
  find_program(EDGE_EXECUTABLE NAMES msedge.exe
               PATH_SUFFIXES "Microsoft/Edge/Application")
  if(EDGE_EXECUTABLE)
    message(STATUS "Found Edge browser executable ${EDGE_EXECUTABLE}")
    set(edgeexe ${EDGE_EXECUTABLE})
  endif()
endif()

find_program(FIREFOX_EXECUTABLE NAMES firefox firefox-bin firefox.exe
             HINTS /snap/bin
             PATH_SUFFIXES "Mozilla Firefox")
if(FIREFOX_EXECUTABLE)
  message(STATUS "Found Firefox browser executable ${FIREFOX_EXECUTABLE}")
  set(firefoxexe ${FIREFOX_EXECUTABLE})
endif()


#---RConfigure-------------------------------------------------------------------------------------------------
# set(setresuid undef)
CHECK_CXX_SOURCE_COMPILES("#include <unistd.h>
  int main() { uid_t r = 0, e = 0, s = 0; if (setresuid(r, e, s) != 0) { }; return 0;}" found_setresuid)
if(found_setresuid)
  set(setresuid define)
else()
  set(setresuid undef)
endif()

if(mathmore)
  set(hasmathmore define)
else()
  set(hasmathmore undef)
endif()
if(imt)
  set(useimt define)
else()
  set(useimt undef)
endif()
if(CMAKE_USE_PTHREADS_INIT)
  set(haspthread define)
else()
  set(haspthread undef)
endif()
if(x11)
  set(hasxft define)
else()
  set(hasxft undef)
endif()
if(lzma)
  set(haslzmacompression define)
else()
  set(haslzmacompression undef)
endif()
if(lz4)
  set(haslz4compression define)
else()
  set(haslz4compression undef)
endif()
if(cocoa)
  set(hascocoa define)
else()
  set(hascocoa undef)
endif()
if(vc)
  set(hasvc define)
else()
  set(hasvc undef)
endif()
if(vdt)
  set(hasvdt define)
else()
  set(hasvdt undef)
endif()
if(veccore)
  set(hasveccore define)
else()
  set(hasveccore undef)
endif()
if(dataframe)
  set(hasdataframe define)
else()
  set(hasdataframe undef)
endif()
if(dev)
  set(use_less_includes define)
else()
  set(use_less_includes undef)
endif()
if((tbb OR builtin_tbb) AND NOT MSVC)
  set(hastbb define)
else()
  set(hastbb undef)
endif()
if(root7)
  set(hasroot7 define)
else()
  set(hasroot7 undef)
endif()

set(uselz4 undef)
set(usezlib undef)
set(uselzma undef)
set(usezstd undef)
set(use${compression_default} define)

# cloudflare zlib is available only on x86 and aarch64 platforms with Linux
# for other platforms we have available builtin zlib 1.2.8
if(builtin_zlib AND ZLIB_CF)
  set(usecloudflarezlib define)
else()
  set(usecloudflarezlib undef)
endif()
if(runtime_cxxmodules)
  set(usecxxmodules define)
else()
  set(usecxxmodules undef)
endif()
if(libcxx)
  set(uselibc++ define)
else()
  set(uselibc++ undef)
endif()
if(gcctoolchain)
  set(setgcctoolchain define)
else()
  set(setgcctoolchain undef)
endif()
if(memory_termination)
  set(memory_term define)
else()
  set(memory_term undef)
endif()
if(cefweb)
  set(hascefweb define)
else()
  set(hascefweb undef)
endif()
if(qt6web)
  set(hasqt6webengine define)
else()
  set(hasqt6webengine undef)
endif()
if (tmva-cpu)
  set(hastmvacpu define)
else()
  set(hastmvacpu undef)
endif()
if (tmva-gpu)
  set(hastmvagpu define)
else()
  set(hastmvagpu undef)
endif()
if (tmva-cudnn)
   set(hastmvacudnn define)
else()
   set(hastmvacudnn undef)
endif()
if (tmva-pymva)
  set(haspymva define)
else()
  set(haspymva undef)
endif()
if (tmva-rmva)
  set(hasrmva define)
else()
  set(hasrmva undef)
endif()
if (uring)
  set(hasuring define)
else()
  set(hasuring undef)
endif()
if (geom)
  set(hasgeom define)
else()
  set(hasgeom undef)
endif()


CHECK_CXX_SOURCE_COMPILES("
inline __attribute__((always_inline)) bool TestBit(unsigned long f) { return f != 0; };
int main() { return TestBit(0); }" found_attribute_always_inline)
if(found_attribute_always_inline)
   set(has_found_attribute_always_inline define)
else()
   set(has_found_attribute_always_inline undef)
endif()

CHECK_CXX_SOURCE_COMPILES("
inline __attribute__((noinline)) bool TestBit(unsigned long f) { return f != 0; };
int main() { return TestBit(0); }" has_found_attribute_noinline)
if(has_found_attribute_noinline)
   set(has_found_attribute_noinline define)
else()
   set(has_found_attribute_noinline undef)
endif()

# The hardware interference size must be stable across all TUs in a ROOT build, so we need to save it in RConfigure.hxx
# Since it can vary for different compilers or tune settings, we cannot base the ABI on a value that might change,
# even be different between compiler and interpreter, or when ROOT is compiled on a different machine.
if(CMAKE_VERSION VERSION_GREATER 3.24) # For older CMake, we simply fall back to 64
set(test_interference_size "
#include <new>
#include <iostream>
int main() {
  std::cout << std::hardware_destructive_interference_size << std::endl;
  return 0;
}
")
try_run(HARDWARE_INTERF_RUN HARDWARE_INTERF_COMPILE
  SOURCE_FROM_VAR test_interference_size.cxx test_interference_size
  RUN_OUTPUT_VARIABLE hardwareinterferencesize)
endif()
if(NOT HARDWARE_INTERF_COMPILE OR NOT HARDWARE_INTERF_RUN EQUAL 0)
  message(STATUS "Could not detect hardware_interference_size in C++. Falling back to 64.")
  set(hardwareinterferencesize 64)
endif()

if(webgui)
   set(root_canvas_class "TWebCanvas")
   set(root_treeviewer_class "RTreeViewer")
   set(root_geompainter_type "web")
else()
   set(root_canvas_class "TRootCanvas")
   set(root_treeviewer_class "TTreeViewer")
   set(root_geompainter_type "root")
endif()

if(root7 AND webgui)
   set(root_browser_class "ROOT::RWebBrowserImp")
else()
   set(root_browser_class "TRootBrowser")
endif()

#---root-config----------------------------------------------------------------------------------------------
ROOT_GET_OPTIONS(features ENABLED)
set(features "cxx${CMAKE_CXX_STANDARD} ${features}")
set(configfeatures ${features})
set(configargs ${ROOT_CONFIGARGS})
set(configoptions ${ROOT_CONFIGARGS})
set(configstd ${CMAKE_CXX${CMAKE_CXX_STANDARD}_STANDARD_COMPILE_OPTION})
get_filename_component(altcc ${CMAKE_C_COMPILER} NAME)
get_filename_component(altcxx ${CMAKE_CXX_COMPILER} NAME)
get_filename_component(altf77 "${CMAKE_Fortran_COMPILER}" NAME)
get_filename_component(altld ${CMAKE_CXX_COMPILER} NAME)

set(pythonvers ${Python3_VERSION})
set(python${Python3_VERSION_MAJOR}vers ${Python3_VERSION})

#---RConfigure.h---------------------------------------------------------------------------------------------
if (CMAKE_CXX_COMPILER_ID STREQUAL "NVHPC")
   execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dM -E /dev/null OUTPUT_VARIABLE __cplusplus_PPout)
else()
   try_compile(has__cplusplus "${CMAKE_BINARY_DIR}" SOURCES "${CMAKE_SOURCE_DIR}/config/__cplusplus.cxx"
            OUTPUT_VARIABLE __cplusplus_PPout)
endif()
string(REGEX MATCH "__cplusplus[=| ]([0-9]+)" __cplusplus "${__cplusplus_PPout}")
set(__cplusplus ${CMAKE_MATCH_1}L)

configure_file(${PROJECT_SOURCE_DIR}/config/RConfigure.in ginclude/RConfigure.h NEWLINE_STYLE UNIX)
install(FILES ${CMAKE_BINARY_DIR}/ginclude/RConfigure.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

#---Configure and install various files----------------------------------------------------------------------
execute_Process(COMMAND hostname OUTPUT_VARIABLE BuildNodeInfo OUTPUT_STRIP_TRAILING_WHITESPACE )

configure_file(${CMAKE_SOURCE_DIR}/config/rootrc.in ${CMAKE_BINARY_DIR}/etc/system.rootrc @ONLY NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/config/rootauthrc.in ${CMAKE_BINARY_DIR}/etc/system.rootauthrc @ONLY NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/config/rootdaemonrc.in ${CMAKE_BINARY_DIR}/etc/system.rootdaemonrc @ONLY NEWLINE_STYLE UNIX)

# file used in TROOT.cxx, not need in include/ dir and not need to install
configure_file(${CMAKE_SOURCE_DIR}/config/RConfigOptions.in ginclude/RConfigOptions.h NEWLINE_STYLE UNIX)

configure_file(${CMAKE_SOURCE_DIR}/config/Makefile-comp.in config/Makefile.comp NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/config/Makefile.in config/Makefile.config NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/config/mimes.unix.in ${CMAKE_BINARY_DIR}/etc/root.mimes NEWLINE_STYLE UNIX)
# We need to have class.rules during configuration time to avoid silent error during generation of dictionary:
# Error in <TClass::ReadRules()>: Cannot find rules
configure_file(${CMAKE_SOURCE_DIR}/etc/class.rules ${CMAKE_BINARY_DIR}/etc/class.rules COPYONLY)

#---Generate the ROOTConfig files to be used by CMake projects-----------------------------------------------
ROOT_GET_OPTIONS(ROOT_ALL_OPTIONS)
ROOT_GET_OPTIONS(ROOT_ENABLED_OPTIONS ENABLED)
configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/ROOTConfig-version.cmake.in
               ${CMAKE_BINARY_DIR}/ROOTConfig-version.cmake @ONLY NEWLINE_STYLE UNIX)

#---Compiler flags (because user apps are a bit dependent on them...)----------------------------------------
string(REGEX REPLACE "(^|[ ]*)-W[^ ]*" "" __cxxflags "${CMAKE_CXX_FLAGS}")
string(REGEX REPLACE "(^|[ ]*)-W[^ ]*" "" __cflags "${CMAKE_C_FLAGS}")

if(MSVC)
  string(REPLACE "-I${CMAKE_SOURCE_DIR}/cmake/win" "" __cxxflags "${__cxxflags}")
  string(REPLACE "-I${CMAKE_SOURCE_DIR}/cmake/win" "" __cflags "${__cflags}")
endif()

string(REGEX REPLACE "(^|[ ]*)-W[^ ]*" "" __fflags "${CMAKE_Fortran_FLAGS}")
string(REGEX MATCHALL "(-Wp,)?-(D|U)[^ ]*" __defs "${CMAKE_CXX_FLAGS}")
set(ROOT_COMPILER_FLAG_HINTS "#
set(ROOT_DEFINITIONS \"${__defs}\")
set(ROOT_CXX_STANDARD ${CMAKE_CXX_STANDARD})
set(ROOT_CXX_FLAGS \"${__cxxflags}\")
set(ROOT_C_FLAGS \"${__cflags}\")
set(ROOT_fortran_FLAGS \"${__fflags}\")
set(ROOT_EXE_LINKER_FLAGS \"${CMAKE_EXE_LINKER_FLAGS}\")")
set(ROOT_BINDIR ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "")

#---To be used from the binary tree--------------------------------------------------------------------------
set(ROOT_INCLUDE_DIR_SETUP "
# ROOT configured for use from the build tree - absolute paths are used.
set(ROOT_INCLUDE_DIRS ${CMAKE_BINARY_DIR}/include)
")
set(ROOT_LIBRARY_DIR_SETUP "
# ROOT configured for use from the build tree - absolute paths are used.
set(ROOT_LIBRARY_DIR ${CMAKE_BINARY_DIR}/lib)
")
set(ROOT_BINDIR_SETUP "
# ROOT configured for use from the build tree - absolute paths are used.
set(ROOT_BINDIR ${CMAKE_BINARY_DIR}/bin)
")
# Deprecated value ROOT_BINARY_DIR
set(ROOT_BINARY_DIR_SETUP "
# Deprecated value, please don't use it and use ROOT_BINDIR instead.
set(ROOT_BINARY_DIR ${ROOT_BINDIR})
")
set(ROOT_CMAKE_DIR_SETUP "
# ROOT configured for use from the build tree - absolute paths are used.
set(ROOT_CMAKE_DIR ${CMAKE_SOURCE_DIR}/cmake)
")

get_property(exported_targets GLOBAL PROPERTY ROOT_EXPORTED_TARGETS)
export(TARGETS ${exported_targets} NAMESPACE ROOT:: FILE ${PROJECT_BINARY_DIR}/ROOTConfig-targets.cmake)
configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/ROOTConfig.cmake.in
               ${CMAKE_BINARY_DIR}/ROOTConfig.cmake @ONLY NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/RootUseFile.cmake.in
               ${CMAKE_BINARY_DIR}/ROOTUseFile.cmake @ONLY NEWLINE_STYLE UNIX)

#---To be used from the install tree--------------------------------------------------------------------------
# Need to calculate actual relative paths from CMAKEDIR to other locations
file(RELATIVE_PATH ROOT_CMAKE_TO_INCLUDE_DIR "${CMAKE_INSTALL_FULL_CMAKEDIR}" "${CMAKE_INSTALL_FULL_INCLUDEDIR}")
file(RELATIVE_PATH ROOT_CMAKE_TO_LIB_DIR "${CMAKE_INSTALL_FULL_CMAKEDIR}" "${CMAKE_INSTALL_FULL_LIBDIR}")
file(RELATIVE_PATH ROOT_CMAKE_TO_BIN_DIR "${CMAKE_INSTALL_FULL_CMAKEDIR}" "${CMAKE_INSTALL_FULL_BINDIR}")

# '_' prefixed variables are used to construct the paths,
# while the normal variants evaluate to full paths at runtime
set(ROOT_INCLUDE_DIR_SETUP "
# ROOT configured for the install with relative paths, so use these
get_filename_component(_ROOT_INCLUDE_DIRS \"\${_thisdir}/${ROOT_CMAKE_TO_INCLUDE_DIR}\" REALPATH)
# resolve relative paths to absolute system paths
get_filename_component(ROOT_INCLUDE_DIRS \"\${_ROOT_INCLUDE_DIRS}\" REALPATH)
")
set(ROOT_LIBRARY_DIR_SETUP "
# ROOT configured for the install with relative paths, so use these
get_filename_component(_ROOT_LIBRARY_DIR \"\${_thisdir}/${ROOT_CMAKE_TO_LIB_DIR}\" REALPATH)
# resolve relative paths to absolute system paths
get_filename_component(ROOT_LIBRARY_DIR \"\${_ROOT_LIBRARY_DIR}\" REALPATH)
")
set(ROOT_BINDIR_SETUP "
# ROOT configured for the install with relative paths, so use these
get_filename_component(_ROOT_BINDIR \"\${_thisdir}/${ROOT_CMAKE_TO_BIN_DIR}\" REALPATH)
# resolve relative paths to absolute system paths
get_filename_component(ROOT_BINDIR \"\${_ROOT_BINDIR}\" REALPATH)
")
# Deprecated value ROOT_BINARY_DIR
set(ROOT_BINARY_DIR_SETUP "
# Deprecated value, please don't use it and use ROOT_BINDIR instead.
get_filename_component(ROOT_BINARY_DIR \"\${ROOT_BINDIR}\" REALPATH)
")
set(ROOT_CMAKE_DIR_SETUP "
## ROOT configured for the install with relative paths, so use these
get_filename_component(ROOT_CMAKE_DIR \"\${_thisdir}\" REALPATH)
")

# used by ROOTConfig.cmake from the build directory
configure_file(${CMAKE_SOURCE_DIR}/cmake/modules/RootMacros.cmake
               ${CMAKE_BINARY_DIR}/RootMacros.cmake COPYONLY)

# used by roottest to run tests against ROOT build
configure_file(${CMAKE_SOURCE_DIR}/cmake/modules/RootTestDriver.cmake
               ${CMAKE_BINARY_DIR}/RootTestDriver.cmake COPYONLY)

configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/ROOTConfig.cmake.in
               ${CMAKE_BINARY_DIR}/installtree/ROOTConfig.cmake @ONLY NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/RootUseFile.cmake.in
               ${CMAKE_BINARY_DIR}/installtree/ROOTUseFile.cmake @ONLY NEWLINE_STYLE UNIX)
install(FILES ${CMAKE_BINARY_DIR}/ROOTConfig-version.cmake
              ${CMAKE_BINARY_DIR}/installtree/ROOTUseFile.cmake
              ${CMAKE_BINARY_DIR}/installtree/ROOTConfig.cmake DESTINATION ${CMAKE_INSTALL_CMAKEDIR})
install(EXPORT ${CMAKE_PROJECT_NAME}Exports NAMESPACE ROOT:: FILE ROOTConfig-targets.cmake DESTINATION ${CMAKE_INSTALL_CMAKEDIR})


#---Especial definitions for root-config et al.--------------------------------------------------------------
if(prefix STREQUAL "$(ROOTSYS)")
  foreach(d prefix bindir libdir incdir etcdir tutdir mandir)
    string(REPLACE "$(ROOTSYS)" "$ROOTSYS"  ${d} ${${d}})
  endforeach()
endif()


#---compiledata.h--------------------------------------------------------------------------------------------

# ROOTBUILD definition (it is defined in compiledata.h and used by ACLIC
# to decide whether (by default) to optimize or not optimize the user scripts.)
if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
  set(ROOTBUILD "debug")
endif()

if(WIN32)
  # We cannot use the compiledata.sh script for windows
  configure_file(${CMAKE_SOURCE_DIR}/cmake/scripts/compiledata.win32.in ${CMAKE_BINARY_DIR}/ginclude/compiledata.h NEWLINE_STYLE UNIX)
else()
  # Needed by ACLIC, while in ROOT we are using everywhere C++ standard via CMake features that are requested to build target
  set(CMAKE_CXX_ACLIC_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX${CMAKE_CXX_STANDARD}_STANDARD_COMPILE_OPTION}")
  if(asan)
    # Replace the semicolon with space so that the produced compiler invokation still makes sense
    string (REPLACE ";" " " ASAN_EXTRA_CXX_FLAGS_STR "${ASAN_EXTRA_CXX_FLAGS}")
    set(CMAKE_CXX_ACLIC_FLAGS "${CMAKE_CXX_ACLIC_FLAGS} ${ASAN_EXTRA_CXX_FLAGS_STR}")
  endif()
  if(ROOT_COMPILEDATA_IGNORE_BUILD_NODE_CHANGES)
    # Only set the compiledata parameter if the CMake variable is 'true'
    set(local_ROOT_COMPILEDATA_IGNORE_BUILD_NODE_CHANGES ${ROOT_COMPILEDATA_IGNORE_BUILD_NODE_CHANGES})
  endif()
  execute_process(COMMAND ${CMAKE_SOURCE_DIR}/cmake/unix/compiledata.sh
    ${CMAKE_BINARY_DIR}/ginclude/compiledata.h "${CMAKE_CXX_COMPILER}"
        "${CMAKE_CXX_FLAGS_RELEASE}" "${CMAKE_CXX_FLAGS_DEBUG}" "${CMAKE_CXX_ACLIC_FLAGS}"
        "${CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS}" "${CMAKE_EXE_LINKER_FLAGS}" "so"
        "${libdir}" "-lCore" "-lRint" "${incdir}" "" "" "${ROOT_ARCHITECTURE}" "${ROOTBUILD}"
        "${local_ROOT_COMPILEDATA_IGNORE_BUILD_NODE_CHANGES}")
endif()

#---Get the values of ROOT_ALL_OPTIONS and CMAKE_CXX_FLAGS provided by the user in the command line
set(all_features ${ROOT_ALL_OPTIONS})
set(usercflags ${CMAKE_CXX_FLAGS-CACHED})
file(REMOVE ${CMAKE_BINARY_DIR}/installtree/root-config)
configure_file(${CMAKE_SOURCE_DIR}/config/root-config.in ${CMAKE_BINARY_DIR}/installtree/root-config @ONLY NEWLINE_STYLE UNIX)
if(thisroot_scripts)
  configure_file(${CMAKE_SOURCE_DIR}/config/thisroot.sh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/thisroot.sh @ONLY NEWLINE_STYLE UNIX)
  configure_file(${CMAKE_SOURCE_DIR}/config/thisroot.csh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/thisroot.csh @ONLY NEWLINE_STYLE UNIX)
  configure_file(${CMAKE_SOURCE_DIR}/config/thisroot.fish ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/thisroot.fish @ONLY NEWLINE_STYLE UNIX)
  list(APPEND list_of_thisroot_scripts thisroot.sh thisroot.csh thisroot.fish setxrd.csh)
endif()
configure_file(${CMAKE_SOURCE_DIR}/config/setxrd.csh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/setxrd.csh COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/config/setxrd.sh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/setxrd.sh COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/config/roots.in ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/roots @ONLY NEWLINE_STYLE UNIX)
configure_file(${CMAKE_SOURCE_DIR}/config/rootssh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/rootssh @ONLY NEWLINE_STYLE UNIX)
if(WIN32)
  if(thisroot_scripts)
    configure_file(${CMAKE_SOURCE_DIR}/config/thisroot.bat ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/thisroot.bat @ONLY)
    configure_file(${CMAKE_SOURCE_DIR}/config/thisroot.ps1 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/thisroot.ps1 @ONLY)
    list(APPEND list_of_thisroot_scripts thisroot.bat thisroot.ps1)
  endif()
  configure_file(${CMAKE_SOURCE_DIR}/config/root.rc.in ${CMAKE_BINARY_DIR}/etc/root.rc @ONLY)
  configure_file(${CMAKE_SOURCE_DIR}/config/root-manifest.xml.in ${CMAKE_BINARY_DIR}/etc/root-manifest.xml @ONLY)
  install(FILES ${CMAKE_SOURCE_DIR}/cmake/win/w32pragma.h  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} COMPONENT headers)
  install(FILES ${CMAKE_SOURCE_DIR}/cmake/win/sehmap.h  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} COMPONENT headers)
endif()

#--Local root-configure
set(prefix $ROOTSYS)
set(bindir $ROOTSYS/bin)
set(libdir $ROOTSYS/lib)
set(incdir $ROOTSYS/include)
set(etcdir $ROOTSYS/etc)
set(tutdir $ROOTSYS/tutorials)
set(mandir $ROOTSYS/man)
configure_file(${CMAKE_SOURCE_DIR}/config/root-config.in ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/root-config @ONLY NEWLINE_STYLE UNIX)
if(MSVC)
  configure_file(${CMAKE_SOURCE_DIR}/config/root-config.bat.in ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/root-config.bat @ONLY)
  install(FILES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/root-config.bat
  PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()

if(DEFINED list_of_thisroot_scripts)
  # Prepend runtime output directory to list of setup scripts
  set(final_list_of_thisroot_scripts "")
  foreach(script IN LISTS list_of_thisroot_scripts)
      list(APPEND final_list_of_thisroot_scripts "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${script}")
  endforeach()

  install(FILES ${final_list_of_thisroot_scripts}
                PERMISSIONS OWNER_WRITE OWNER_READ
                            GROUP_READ
                            WORLD_READ
                DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()

install(FILES ${CMAKE_BINARY_DIR}/installtree/root-config
              ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/roots
              ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/rootssh
              PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                          GROUP_EXECUTE GROUP_READ
                          WORLD_EXECUTE WORLD_READ
              DESTINATION ${CMAKE_INSTALL_BINDIR})

install(FILES ${CMAKE_BINARY_DIR}/ginclude/RConfigOptions.h
              ${CMAKE_BINARY_DIR}/ginclude/compiledata.h
              DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(FILES ${CMAKE_BINARY_DIR}/etc/root.mimes
              ${CMAKE_BINARY_DIR}/etc/system.rootrc
              ${CMAKE_BINARY_DIR}/etc/system.rootauthrc
              ${CMAKE_BINARY_DIR}/etc/system.rootdaemonrc
              DESTINATION ${CMAKE_INSTALL_SYSCONFDIR})

if(NOT gnuinstall)
  install(FILES ${CMAKE_BINARY_DIR}/config/Makefile.comp
                ${CMAKE_BINARY_DIR}/config/Makefile.config
                DESTINATION config)
endif()


endfunction()
RootConfigure()
