{ lib, makeWrapper, qt6, imgbrd-grabber }:

imgbrd-grabber.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [
    ./imgbrd-grabber-linux-pixiv-pkce.patch
  ];
  buildInputs = (old.buildInputs or [ ]) ++ [ qt6.qtwebengine ];
  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ makeWrapper ];

  postPatch = (old.postPatch or "") + ''
    substituteInPlace gui/src/sources/sources-settings-window.cpp \
      --replace-fail \
        $'#if !defined(USE_WEBENGINE)\n\t#include "webview-window.h"\n#endif' \
        $'#include "webview-window.h"' \
      --replace-fail \
        $'#if !defined(USE_WEBENGINE)\n\t\tui->buttonOpenInWebView->setDisabled(true);\n\t#endif' \
        "" \
      --replace-fail \
        $'void SourcesSettingsWindow::openInWebView()\n{\n\t#if defined(USE_WEBENGINE)\n\t\tauto *window = new WebViewWindow(m_site, this);\n\t\twindow->show();\n\t#endif\n}' \
        $'void SourcesSettingsWindow::openInWebView()\n{\n\t\tauto *window = new WebViewWindow(m_site, this);\n\t\twindow->show();\n}'

    substituteInPlace lib/CMakeLists.txt \
      --replace-fail \
        "find_package(Qt6 COMPONENTS Core Concurrent Gui Network NetworkAuth Qml Sql Xml REQUIRED)" \
        "find_package(Qt6 COMPONENTS Core Concurrent Gui Network NetworkAuth Qml Sql Widgets Xml WebEngineCore WebEngineWidgets REQUIRED)" \
      --replace-fail \
        "set(QT_LIBRARIES Qt6::Core Qt6::Concurrent Qt6::Gui Qt6::Network Qt6::NetworkAuth Qt6::Qml Qt6::Sql Qt6::Xml)" \
        "set(QT_LIBRARIES Qt6::Core Qt6::Concurrent Qt6::Gui Qt6::Network Qt6::NetworkAuth Qt6::Qml Qt6::Sql Qt6::Widgets Qt6::Xml Qt6::WebEngineCore Qt6::WebEngineWidgets)" \
      --replace-fail \
        "if(FALSE AND TARGET Qt6::WebEngineCore)" \
        "if(TARGET Qt6::WebEngineCore AND TARGET Qt6::WebEngineWidgets)"

    substituteInPlace gui/CMakeLists.txt \
      --replace-fail \
        "find_package(Qt6 COMPONENTS NetworkAuth Core Concurrent Gui Network NetworkAuth Multimedia MultimediaWidgets Qml Sql Widgets Xml REQUIRED)" \
        "find_package(Qt6 COMPONENTS NetworkAuth Core Concurrent Gui Network NetworkAuth Multimedia MultimediaWidgets Qml Sql Widgets Xml WebEngineCore WebEngineWidgets REQUIRED)" \
      --replace-fail \
        "set(QT_LIBRARIES Qt6::NetworkAuth Qt6::Core Qt6::Concurrent Qt6::Gui Qt6::Multimedia Qt6::MultimediaWidgets Qt6::Network Qt6::NetworkAuth Qt6::Qml Qt6::Sql Qt6::Widgets Qt6::Xml)" \
        "set(QT_LIBRARIES Qt6::NetworkAuth Qt6::Core Qt6::Concurrent Qt6::Gui Qt6::Multimedia Qt6::MultimediaWidgets Qt6::Network Qt6::NetworkAuth Qt6::Qml Qt6::Sql Qt6::Widgets Qt6::Xml Qt6::WebEngineCore Qt6::WebEngineWidgets)" \
      --replace-fail \
        "if(FALSE AND TARGET Qt6::WebEngineCore AND TARGET Qt6::WebEngineWidgets)" \
        "if(TARGET Qt6::WebEngineCore AND TARGET Qt6::WebEngineWidgets)"

  '';

  postFixup = (old.postFixup or "") + ''
    wrapProgram $out/bin/Grabber \
      --set QTWEBENGINEPROCESS_PATH "${qt6.qtwebengine}/libexec/QtWebEngineProcess" \
      --set QTWEBENGINE_LOCALES_PATH "${qt6.qtwebengine}/qtwebengine_locales" \
      --set QTWEBENGINE_RESOURCES_PATH "${qt6.qtwebengine}/resources" \
      --set XDG_DATA_DIRS "${lib.makeSearchPath "share" [ qt6.qtwebengine ]}:''${XDG_DATA_DIRS:-}"
  '';
})
