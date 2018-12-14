//Подключаем стандартные библиотеки в стиле QML
//Основные концепции языка:
//Проект (Project), Продукт (Product), Артефакт (Artifact), Модуль (Module), Правило (Rule), Группа(Group), Зависимость (Depends), Тег (Tag).
//Продукт — это аналог pro или vcproj, т. е. одна цель для сборки.
//Проект — это набор ваших продуктов вместе с зависимостями, воспринимаемый системой сборки как одно целое. Один проект — один граф сборки.
//Тег — система классификации файлов. Например «*.cpp» => «cpp»
//Правило — Преобразование файлов проекта, отмеченных определенными тегами. Генерирует другие файлы, называемые Артефактами.
//Как правило, это компиляторы или другие системы сборки.
//Артефакт — файл, над который является выходным для правила (и возможно, входным для други правил). Это обычно «obj», «exe» файлы.
//У многих QML-объектов есть свойство condition, которое отвечает за то, будет собираться он или нет. А если нам необходимо разделить так файлы?
//Для этого их можно объединить в группу (Group)
//Rule умеет срабатывать на каждый файл, попадающий под что-то. Может срабатывать по разу на каждый фаил (например, для вызова компилятора), а может один раз на все (линкер).
//Transformer предназначен для срабатывания только на один фаил, с заранее определенным именем. Например, прошивальщик или какой-нибудь хитрый скрипт.
//флаг multiplex, который говорит о том, что это правило обрабатывает сразу все файлы данного типа скопом.

// We connect standard libraries in style QML
// Basic concepts of the language:
// Project, Product, Artifact, Module, Rule, Group, Depends, Tag.
// The product is an analog of pro or vcproj, that is, one target for the assembly.
// The project is a set of your products together with dependencies, perceived by the build system as one. One project - one assembly graph.
// Tag - file classification system. For example, "* .cpp" => "cpp"
// Rule - Converting project files marked with certain tags. Generates other files called Artifacts.
// Typically, these are compilers or other build systems.
// Artifact is the file over which is the output for the rule (and possibly the input for other rules). These are usually "obj", "exe" files.
// Many QML objects have a condition property, which is responsible for whether it will be assembled or not. And if we need to split the files like this?
// To do this, you can group them into a group (Group)
// Rule is able to work on every file that falls under something. It can trigger once per each file (for example, to call the compiler), but can once on all (linker).
// Transformer is intended for triggering only one file, with a predefined name. For example, the broacher or some cunning script.
// the multiplex flag, which says that this rule processes all files of this type at once.

import qbs
import qbs.FileInfo
import qbs.ModUtils

CppApplication {

    // основной элемент файла - проект.

    //    moduleSearchPaths: "qbs" // Папка для поиска дополнительных модулей, таких как cpp и qt

    // Один проект может состоять из нескольких продуктов - конечных целей сборки.
    // Один проект может состоять из нескольких продуктов - конечных целей сборки.
    // указываем связанные файлы с помощью references. Внимание: это не жестко заданный порядок!
    // Порядок задается с помощью зависимостей, о них позже
    //    references: [
    //           "*.qbs",
    //       ]

    // the main element of the file is the project.

    // moduleSearchPaths: "qbs" // Folder for finding additional modules, such as cpp and qt

    // One project can consist of several products - the final assembly goals.
    // One project can consist of several products - the final assembly goals.
    // specify the related files with references. Attention: this is not a rigidly prescribed order!
    // The order is specified using dependencies, about them later
    // references: [
    // "* .qbs",
    //]


    name: "QT-STM32746G-Discovery"
    // Название выходного файла (без суффикса, он зависит от цели)
    // The name of the output file (without the suffix, it depends on the purpose)
    type: [
        "application",
        "bin",
        "hex",
        // Тип - приложение, т.е. исполняемый файл.
        // Type - application, i.e. executable file.
    ]

    Depends {
        name: "cpp"
        // Этот продукт зависит от компилятора C++
        // This product depends on the C ++ compiler
    }

    consoleApplication: true
    cpp.positionIndependentCode: false
    cpp.executableSuffix: ".elf"

    property string Home: path + "/.."
    property string Config: Home + "/Config"
    property string FreeRTOS: Home + "/Middlewares/Third_Party/FreeRTOS"
    property string CMSIS_RTOS: FreeRTOS + "/Source/CMSIS_RTOS"
    property string FatFs: Home + "/Middlewares/Third_Party/FatFs"
    property string HAL: Home + "/Drivers/STM32F7xx_HAL_Driver"
    property string CMSIS: Home + "/Drivers/CMSIS"
    property string TouchGFX: Home + "/Gui"
    property string Inc: Home + "/Core/Inc"
    property string Src: Home + "/Core/Src"
    property string startup: Home + "/startup"
    property string USB_HOST: Home + "/Middlewares/ST/STM32_USB_Host_Library"
    property string GUIBuilder: Home + "/GUIBuilder"
    property string BSP: Home + "/Drivers/BSP/STM32746G-Discovery"
    property string Utilities: Home + "/Utilities"
    property string Components: Home + "/Drivers/BSP/Components"
    property string Modules: Home + "/Modules"
    property string lwip: Home + "/Middlewares/Third_Party/LwIP"


    Group {
        // Имя группы
        // A group name
        name: "Template"
        // Список файлов в данном проекте.
        // List of files in this project.
        files: [
        ]
        // Каталоги с включенными файлами
        // Directories with included files
        cpp.includePaths: [
        ]
        // Пути до библиотек
        // Paths to Libraries
        cpp.libraryPaths: []
    }


    Group {
        //Имя группы
        name: "TouchGFX"
        //Список файлов в данном проекте.

        files: [
            TouchGFX + "/generated/fonts/src/ApplicationFontProvider.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Bold_otf_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Bold_otf_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Bold_otf_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Bold_otf_46_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Regular_11_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Regular_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_Asap_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_ipaexg_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_ipaexg_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_NotoSans_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Font_NotoSans_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/FontGetters.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Bold_otf_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Bold_otf_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Bold_otf_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Bold_otf_46_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Regular_11_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Regular_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_Asap_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_ipaexg_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_ipaexg_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_NotoSans_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Kerning_NotoSans_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Bold_otf_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Bold_otf_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Bold_otf_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Bold_otf_46_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Regular_11_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Regular_15_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_Asap_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_ipaexg_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_ipaexg_18_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_NotoSans_Regular_12_4bpp.cpp",
            TouchGFX + "/generated/fonts/src/Table_NotoSans_Regular_18_4bpp.cpp",
            TouchGFX + "/generated/images/src/BitmapDatabase.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_center_button.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_center_button_pressed.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_color_wheel.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_down.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_down_inactive.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_down_pressed.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_up-inactive.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_up-pressed.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_arrow_up.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_button.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_button_pressed.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_datepicker_large.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_datepicker_small.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_gauge_large.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_gauge_small.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_percentage_large.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_percentage_small.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_three_way_large.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_icon_three_way_small.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_shadow_bottom.cpp",
            TouchGFX + "/generated/images/src/CustomControls/control_menu_shadow_top.cpp",
            TouchGFX + "/generated/images/src/CustomControls/controls_background.cpp",
            TouchGFX + "/generated/images/src/CustomControls/controls_menu_background.cpp",
            TouchGFX + "/generated/images/src/CustomControls/controls_three_way_small_circle.cpp",
            TouchGFX + "/generated/images/src/CustomControls/controls_wheel_background.cpp",
            TouchGFX + "/generated/images/src/CustomControls/datepicker_bottom_shadow_overlay.cpp",
            TouchGFX + "/generated/images/src/CustomControls/datepicker_glass_overlay.cpp",
            TouchGFX + "/generated/images/src/CustomControls/datepicker_main_background.cpp",
            TouchGFX + "/generated/images/src/CustomControls/datepicker_top_shadow_overlay.cpp",
            TouchGFX + "/generated/images/src/CustomControls/gauge_background.cpp",
            TouchGFX + "/generated/images/src/CustomControls/gauge_needle_pin.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_bin_icon_active.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_bin_icon_inactive.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_folder_icon_active.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_folder_icon_inactive.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_papers_icon_active.cpp",
            TouchGFX + "/generated/images/src/CustomControls/small_circle_papers_icon_inactive.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_background.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_bottom_menu.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_bottom_menu_active.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_bottom_menu_selected.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_dot.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_menu_button.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_menu_button_pressed.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_side_menu_button.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_side_menu_button_active.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/easing_side_menu_button_selected.cpp",
            TouchGFX + "/generated/images/src/EasingEquation/graphDot.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_area_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_area_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_dots_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_dots_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_line_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/blue_line_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_background_bottom.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_menu_button.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_menu_button_pressed.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_toggle_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_toggle_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_top_menu_activate_button.cpp",
            TouchGFX + "/generated/images/src/Graph/graph_top_menu_line.cpp",
            TouchGFX + "/generated/images/src/Graph/green_area_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/green_area_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/green_dots_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/green_dots_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/green_line_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/green_line_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/half_circle_toggle_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/half_circle_toggle_button_inactive.cpp",
            TouchGFX + "/generated/images/src/Graph/new_graph.cpp",
            TouchGFX + "/generated/images/src/Graph/new_graph_pressed.cpp",
            TouchGFX + "/generated/images/src/Graph/new_pie_chart.cpp",
            TouchGFX + "/generated/images/src/Graph/new_pie_chart_pressed.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_blue.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_blue_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_green.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_green_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_orange.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_orange_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_purple.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_purple_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_red.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_red_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_yellow.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_chart_legend_yellow_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_toggle_button_active.cpp",
            TouchGFX + "/generated/images/src/Graph/pie_toggle_button_inactive.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_01.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_01_pressed.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_02_03.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_02_03_pressed.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_04.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_04_pressed.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_05_06.cpp",
            TouchGFX + "/generated/images/src/MainMenu/demo_button_05_06_pressed.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_demo_screen_02.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_demo_screen_03.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_demo_screen_04.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_demo_screen_05.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_stage_stretch_left_side.cpp",
            TouchGFX + "/generated/images/src/MainMenu/menu_stage_stretch_right_side.cpp",
            TouchGFX + "/generated/images/src/MainMenu/screen_swipe_dots_active.cpp",
            TouchGFX + "/generated/images/src/MainMenu/screen_swipe_dots_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_dnk_active.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_dnk_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_gbr_active.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_gbr_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_jpn_active.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_jpn_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_nld_active.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_nld_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_ukr_active.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/flag_ukr_inactive.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/poster_image_00.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/poster_image_01.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/poster_image_02.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/product_presenter_menu_button.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/product_presenter_menu_button_pressed.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/product_presenter_nav_bar.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/product_presenter_next.cpp",
            TouchGFX + "/generated/images/src/ProductPresenter/product_presenter_next_pressed.cpp",
            TouchGFX + "/generated/texts/src/LanguageDnk.cpp",
            TouchGFX + "/generated/texts/src/LanguageGbr.cpp",
            TouchGFX + "/generated/texts/src/LanguageJpn.cpp",
            TouchGFX + "/generated/texts/src/LanguageNld.cpp",
            TouchGFX + "/generated/texts/src/LanguageUkr.cpp",
            TouchGFX + "/generated/texts/src/Texts.cpp",
            TouchGFX + "/generated/texts/src/TypedTextDatabase.cpp",
            TouchGFX + "/gui/src/common/CollapsibleMenu.cpp",
            TouchGFX + "/gui/src/common/DemoPresenter.cpp",
            TouchGFX + "/gui/src/common/DotIndicator.cpp",
            TouchGFX + "/gui/src/common/FrontendApplication.cpp",
            TouchGFX + "/gui/src/common/SwipeContainer.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/CircularProgress.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/CustomControlsPresenter.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/CustomControlsView.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/DatePicker.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/Gauge.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/ThreeWayProgressBar.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/ThreeWayProgressBarCircle.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/VerticalSlideMenu.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/WheelSelector.cpp",
            TouchGFX + "/gui/src/custom_controls_screen/WheelSelectorExtra.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationButton.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationGraph.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationInOrOutOrInOut.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationPresenter.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationSelector.cpp",
            TouchGFX + "/gui/src/easing_equation_screen/EasingEquationView.cpp",
            TouchGFX + "/gui/src/graph_screen/AbstractGraph.cpp",
            TouchGFX + "/gui/src/graph_screen/Graph.cpp",
            TouchGFX + "/gui/src/graph_screen/GraphBelow.cpp",
            TouchGFX + "/gui/src/graph_screen/GraphDots.cpp",
            TouchGFX + "/gui/src/graph_screen/GraphLine.cpp",
            TouchGFX + "/gui/src/graph_screen/GraphPresenter.cpp",
            TouchGFX + "/gui/src/graph_screen/GraphView.cpp",
            TouchGFX + "/gui/src/graph_screen/LegendEntry.cpp",
            TouchGFX + "/gui/src/graph_screen/PainterVerticalAlpha.cpp",
            TouchGFX + "/gui/src/graph_screen/PieChart.cpp",
            TouchGFX + "/gui/src/main_menu_screen/MainMenuPresenter.cpp",
            TouchGFX + "/gui/src/main_menu_screen/MainMenuView.cpp",
            TouchGFX + "/gui/src/model/Model.cpp",
            TouchGFX + "/gui/src/product_presenter_screen/ProductPresenterPresenter.cpp",
            TouchGFX + "/gui/src/product_presenter_screen/ProductPresenterView.cpp",
            Home + "/Middlewares/ST/TouchGFX/touchgfx/os/OSWrappers.cpp",
            TouchGFX + "/target/BoardConfiguration.cpp",
            TouchGFX + "/target/GPIO.cpp",
            TouchGFX + "/target/STM32F746GTouchController.cpp",
            TouchGFX + "/target/STM32F7DMA.cpp",
            TouchGFX + "/target/STM32F7HAL.cpp",
            TouchGFX + "/target/STM32F7Instrumentation.cpp",

            TouchGFX + "/gui/include/*/*/*.hpp",
            TouchGFX + "/target/*.hpp",
            TouchGFX + "/platform/os/*.hpp",
            TouchGFX + "/generated/fonts/include/*/*.hpp",
            TouchGFX + "/generated/images/include/*/*.hpp",
            TouchGFX + "/generated/texts/include/*/*.hpp",
            TouchGFX + "/generated/gui_generated/include/*/*.hpp",
            Home     + "/Middlewares/ST/TouchGFX/touchgfx/framework/include/*/*.hpp",
        ]

    }

    Group {
        name: "Components"
        files: [
            Components + "/ft5336/*.c",
            Components + "/ft5336/*.h",
            Components + "/wm8994/*.c",
            Components + "/wm8994/*.h",
        ]
    }

    Group {
        name: "BSP"
        files: [
            BSP + "/*.c",
            BSP + "/*.h",
        ]
    }

    Group {
        name: "GUIBuilder"
        files: [
            GUIBuilder + "/*.c",
        ]
    }

    Group {
        name: "FreRTOS v9.0.0"
        files: [
            FreeRTOS + "/Source/*.c",
            FreeRTOS + "/Source/include/*.h",
            FreeRTOS + "/Source/portable/GCC/ARM_CM7/r0p1/*.h",
            FreeRTOS + "/Source/portable/GCC/ARM_CM7/r0p1/*.c",
            FreeRTOS + "/Source/portable/Common/mpu_wrappers.c",
            FreeRTOS + "/Source/portable/MemMang/heap_4.c",
        ]
        excludeFiles: [
            FreeRTOS + "/Source/include/FreeRTOSConfig_template.h",
        ]
    }

    Group {
        name: "CMSIS_RTOS"
        files: [
            CMSIS_RTOS + "/*.c",
            CMSIS_RTOS + "/*.h",
        ]
    }

    Group {
        name: "HAL"
        files: [
            HAL + "/Src/*.c",
            HAL + "/Inc/*.h",
            HAL + "/Inc/Legacy/*.h",
        ]
        excludeFiles: [
            HAL + "/Src/stm32f7xx_hal_timebase_rtc_alarm_template.c",
            HAL + "/Src/stm32f7xx_hal_timebase_rtc_wakeup_template.c",
            HAL + "/Src/stm32f7xx_hal_timebase_tim_template.c",
        ]
    }

    Group {
        name: "CMSIS"
        files: [
            CMSIS + "/Include/*.h",
            CMSIS + "/Device/ST/STM32F7xx/Source/Templates/*",
            CMSIS + "/Device/ST/STM32F7xx/Include/*.h",
        ]
        excludeFiles: [
            CMSIS + "/Device/ST/STM32F7xx/Source/Templates/system_stm32f7xx.c",
        ]
    }

    Group {
        name: "Inc"
        files: [
            Inc + "/*.h",
        ]

    }

    Group {
        name: "Src"

        files: [
            Src + "/*.c",
            Src + "/*.cpp",
        ]

    }

    Group {
        name: "startup"
        files: [
            startup + "/*.s",
        ]

    }

    Group {
        // Имя группы
        // A group name
        name: "LD"
        // Список файлов в данном проекте
        // List of files in this project
        files: [
            Home + "/*.ld",
        ]
    }

    // Каталоги с включенными файлами
    // Directories with included files
    cpp.includePaths: [
        CMSIS + "/Include",
        CMSIS + "/Device/ST/STM32F7xx/Include",

        Inc,

        FreeRTOS + "/Source/include",
        FreeRTOS + "/Source/portable/GCC/ARM_CM7/r0p1",

        CMSIS_RTOS,

        HAL + "/Inc",
        HAL + "/Inc/Legacy",

        BSP,

        TouchGFX + "/gui/include",
        TouchGFX + "/gui/include/gui",
        TouchGFX + "/gui",
        TouchGFX + "/target",
        TouchGFX + "",
//        TouchGFX + "/platform/os",
        TouchGFX + "/generated/fonts/include",
        TouchGFX + "/generated/fonts",
        TouchGFX + "/generated/images/include",
        TouchGFX + "/generated/images",
        TouchGFX + "/generated/texts/include",
        TouchGFX + "/generated/texts",
        TouchGFX + "/generated/gui_generated/include",
        TouchGFX + "/generated/gui_generated",

        Home     + "/Middlewares/ST/TouchGFX/touchgfx/framework/include",
        Home     + "/Middlewares/ST/TouchGFX/touchgfx/framework",
        Home     + "/Middlewares/ST/TouchGFX/touchgfx",
        Home     + "/Middlewares/ST/TouchGFX",

    ]

    cpp.defines: [
        "USE_HAL_DRIVER",
        "STM32F746xx",
        "USE_STM32746G_DISCOVERY",
        "__weak=__attribute__((weak))",
        "__packed=__attribute__((__packed__))",
        "USE_BPP=16",
        "ST",

    ]

    //    --------------------------------------------------------------------
    //    | ARM Core | Command Line Options                       | multilib |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M0+| -mthumb -mcpu=cortex-m0plus                | armv6-m  |
    //    |Cortex-M0 | -mthumb -mcpu=cortex-m0                    |          |
    //    |Cortex-M1 | -mthumb -mcpu=cortex-m1                    |          |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv6-m                     |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M3 | -mthumb -mcpu=cortex-m3                    | armv7-m  |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7-m                     |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M4 | -mthumb -mcpu=cortex-m4                    | armv7e-m |
    //    |(No FP)   |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m                    |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M4 | -mthumb -mcpu=cortex-m4 -mfloat-abi=softfp | armv7e-m |
    //    |(Soft FP) | -mfpu=fpv4-sp-d16                          | /softfp  |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=softfp |          |
    //    |          | -mfpu=fpv4-sp-d16                          |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M4 | -mthumb -mcpu=cortex-m4 -mfloat-abi=hard   | armv7e-m |
    //    |(Hard FP) | -mfpu=fpv4-sp-d16                          | /fpu     |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=hard   |          |
    //    |          | -mfpu=fpv4-sp-d16                          |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M7 | -mthumb -mcpu=cortex-m7                    | armv7e-m |
    //    |(No FP)   |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m                    |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M7 | -mthumb -mcpu=cortex-m7 -mfloat-abi=softfp | armv7e-m |
    //    |(Soft FP) | -mfpu=fpv5-sp-d16                          | /softfp  |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=softfp |          |
    //    |          | -mfpu=fpv5-sp-d16                          |          |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -mcpu=cortex-m7 -mfloat-abi=softfp |          |
    //    |          | -mfpu=fpv5-d16                             |          |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=softfp |          |
    //    |          | -mfpu=fpv5-d16                             |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-M7 | -mthumb -mcpu=cortex-m7 -mfloat-abi=hard   | armv7e-m |
    //    |(Hard FP) | -mfpu=fpv5-sp-d16                          | /fpu     |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=hard   |          |
    //    |          | -mfpu=fpv5-sp-d16                          |          |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -mcpu=cortex-m7 -mfloat-abi=hard   |          |
    //    |          | -mfpu=fpv5-d16                             |          |
    //    |          |--------------------------------------------|          |
    //    |          | -mthumb -march=armv7e-m -mfloat-abi=hard   |          |
    //    |          | -mfpu=fpv5-d16                             |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-R4 | [-mthumb] -march=armv7-r                   | armv7-ar |
    //    |Cortex-R5 |                                            | /thumb   |
    //    |Cortex-R7 |                                            |          |
    //    |(No FP)   |                                            |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-R4 | [-mthumb] -march=armv7-r -mfloat-abi=softfp| armv7-ar |
    //    |Cortex-R5 | -mfpu=vfpv3-d16                            | /thumb   |
    //    |Cortex-R7 |                                            | /softfp  |
    //    |(Soft FP) |                                            |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-R4 | [-mthumb] -march=armv7-r -mfloat-abi=hard  | armv7-ar |
    //    |Cortex-R5 | -mfpu=vfpv3-d16                            | /thumb   |
    //    |Cortex-R7 |                                            | /fpu     |
    //    |(Hard FP) |                                            |          |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-A* | [-mthumb] -march=armv7-a                   | armv7-ar |
    //    |(No FP)   |                                            | /thumb   |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-A* | [-mthumb] -march=armv7-a -mfloat-abi=softfp| armv7-ar |
    //    |(Soft FP) | -mfpu=vfpv3-d16                            | /thumb   |
    //    |          |                                            | /softfp  |
    //    |----------|--------------------------------------------|----------|
    //    |Cortex-A* | [-mthumb] -march=armv7-a -mfloat-abi=hard  | armv7-ar |
    //    |(Hard FP) | -mfpu=vfpv3-d16                            | /thumb   |
    //    |          |                                            | /fpu     |
    //    --------------------------------------------------------------------


    cpp.cLanguageVersion: "c11"
    cpp.cxxLanguageVersion: "c++17"

    cpp.commonCompilerFlags: [
        "-mcpu=cortex-m7",
        "-mfloat-abi=hard",
        "-mfpu=fpv5-sp-d16",
        "-mthumb",

        "-fmessage-length=0",
        "-Wno-strict-aliasing",

        "-fno-exceptions",
        "-fno-rtti",

    ]

    cpp.driverFlags: [
        "-mcpu=cortex-m7",
        "-mfloat-abi=hard",
        "-mfpu=fpv5-sp-d16",
        "-mthumb",
        "-Xlinker",
        "--gc-sections",

        "-specs=nosys.specs",
        "-specs=nano.specs",

        "-ffunction-sections",				// for removing unused code in linker

        "-Wno-strict-aliasing",
        "-fmessage-length=0",				// If n is zero, then no line-wrapping is done; each error message appears on a single line.


        "-fno-exceptions",
        "-fno-rtti",


        "-Wl,-Map=" + path + "/../QT-STM32746G-Discovery.map",

    ]

    cpp.libraryPaths: [
            Home + "/Middlewares/ST/TouchGFX/touchgfx/lib/core/cortex_m7/gcc",
            Home + "/Middlewares/ST/STM32_Audio/Addons/PDM/Lib",
    ]

    cpp.staticLibraries: [
         ":libtouchgfx-float-abi-hard.a",
         ":libPDMFilter_CM7_GCC_wc32.a",
    ]

    cpp.linkerFlags: [
        "--start-group",
        "--gc-sections",

        "-lm",
        "-T" + path + "/../STM32F746NGHx_FLASH.ld",

        "-lnosys",
        "-lgcc",
        "-lc",
        "-lstdc++",


    ]

    Properties {
        condition: qbs.buildVariant === "debug"
        cpp.debugInformation: true
        cpp.optimization: "none"
    }

    Properties {
        condition: qbs.buildVariant === "release"
        cpp.debugInformation: false
        cpp.optimization: "small"
        // Виды оптимизаций
        // Types of optimizations
        // "none", "fast", "small"
    }

    Properties {
        condition: cpp.debugInformation
        cpp.defines: outer.concat("DEBUG")
    }

    Group {
        // Properties for the produced executable
        // Свойства созданного исполняемого файла
        fileTagsFilter: product.type
        qbs.install: true
    }

    // Создать .bin файл
    // Create a .bin file
    Rule {
        id: binDebugFrmw
        condition: qbs.buildVariant === "debug"
        inputs: ["application"]

        Artifact {
            fileTags: ["bin"]
            filePath: input.baseDir + "/" + input.baseName + ".bin"
        }

        prepare: {
            var objCopyPath = "arm-none-eabi-objcopy"
            var argsConv = ["-O", "binary", input.filePath, output.filePath]
            var cmd = new Command(objCopyPath, argsConv)
            cmd.description = "converting to BIN: " + FileInfo.fileName(
                        input.filePath) + " -> " + input.baseName + ".bin"

            // Запись в nor память по qspi
            // Write to the nor memory by qspi
            var argsFlashingQspi =
            [           "-f", "board/stm32f746g-disco.cfg",
                        "-c", "init",
                        "-c", "reset init",
                        "-c", "flash write_bank 1 " + output.filePath + " 0",
                        "-c", "reset",
                        "-c", "shutdown"
            ]

            var cmdFlashQspi = new Command("openocd", argsFlashingQspi);
            cmdFlashQspi.description = "Wrtie to the NOR QSPI"

            // Запись во внутреннюю память
            // Write to the internal memory
            var argsFlashingInternalFlash =
            [           "-f", "board/stm32f746g-disco.cfg",
                        "-c", "init",
                        "-c", "reset init",
                        "-c", "flash write_image erase " + input.filePath,
                        "-c", "reset",
                        "-c", "shutdown"
            ]

            var cmdFlashInternalFlash = new Command("openocd", argsFlashingInternalFlash);
            cmdFlashInternalFlash.description = "Wrtie to the internal flash"

//            return [cmd, cmdFlashQspi, cmdFlashInternalFlash]
            return [cmd]
        }
    }

    // Создать .bin файл
    // Create a .bin file
    Rule {
        id: binFrmw
        condition: qbs.buildVariant === "release"
        inputs: ["application"]

        Artifact {
            fileTags: ["bin"]
            filePath: input.baseDir + "/" + input.baseName + ".bin"
        }

        prepare: {
            var objCopyPath = "arm-none-eabi-objcopy"
            var argsConv = ["-O", "binary", input.filePath, output.filePath]
            var cmd = new Command(objCopyPath, argsConv)
            cmd.description = "converting to BIN: " + FileInfo.fileName(
                        input.filePath) + " -> " + input.baseName + ".bin"

            // Запись в nor память по qspi
            // Write to the nor memory by qspi
            var argsFlashingQspi =
            [           "-f", "board/stm32f746g-disco.cfg",
                        "-c", "init",
                        "-c", "reset init",
                        "-c", "flash write_bank 1 " + output.filePath + " 0",
                        "-c", "reset",
                        "-c", "shutdown"
            ]

            var cmdFlashQspi = new Command("openocd", argsFlashingQspi);
            cmdFlashQspi.description = "Wrtie to the NOR QSPI"

            // Запись во внутреннюю память
            // Write to the internal memory
            var argsFlashingInternalFlash =
            [           "-f", "board/stm32f746g-disco.cfg",
                        "-c", "init",
                        "-c", "reset init",
                        "-c", "flash write_image erase " + input.filePath,
                        "-c", "reset",
                        "-c", "shutdown"
            ]

            var cmdFlashInternalFlash = new Command("openocd", argsFlashingInternalFlash);
            cmdFlashInternalFlash.description = "Wrtie to the internal flash"

//            return [cmd, cmdFlashQspi, cmdFlashInternalFlash]
            return [cmd]
        }
    }

    // Создать .hex файл
    // Create a .hex file
    Rule {
        id: hexFrmw
        condition: qbs.buildVariant === "release"
        inputs: ["application"]

        Artifact {
            fileTags: ["hex"]
            filePath: input.baseDir + "/" + input.baseName + ".hex"
        }

        prepare: {
            var objCopyPath = "arm-none-eabi-objcopy"
            var argsConv = ["-O", "ihex", input.filePath, output.filePath]
            var cmd = new Command(objCopyPath, argsConv)
            cmd.description = "converting to HEX: " + FileInfo.fileName(
                        input.filePath) + " -> " + input.baseName + ".hex"

            return [cmd]
        }
    }
}
