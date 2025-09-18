
# 🐍 Neovim Config: Python & Modern Dev (Arch/Hyprland)

> Configuración modular, minimalista y poderosa para Neovim, optimizada para Python, desarrollo moderno, IA y automatización total. Integración avanzada de plugins, keymaps inteligentes y experiencia visual premium.

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

## 📋 Índice

- [✨ Características](#-características)
- [📦 Dependencias](#-dependencias)
- [⚡ Instalación Rápida](#-instalación-rápida)
- [📁 Estructura de Archivos](#-estructura-de-archivos)
- [🔧 Plugins y Automatización](#-plugins-y-automatización)
- [⚙️ Configuración Detallada](#️-configuración-detallada)
- [🚀 Uso Diario](#-uso-diario)
- [⌨️ Keymaps Principales](#️-keymaps-principales)
- [🎯 Personalización Avanzada](#-personalización-avanzada)
- [🔍 Troubleshooting](#-troubleshooting)
- [📚 Referencias](#-referencias)

## ✨ Características

- **Neovim + Lua**: Configuración modular y mantenible en Lua.
- **LSP para Python**: Integración completa con `pyright` y autocompletado avanzado.
- **Formateo y linting**: Soporte para `black`, `isort`, `flake8` y más.
- **Snippets y autocompletado**: Integración con `nvim-cmp` y snippets personalizados.
- **Depuración**: Debugging interactivo con `nvim-dap`.
- **UI Moderna**: Temas Catppuccin y soporte para iconos Nerd Font.
- **Gestión de plugins**: Usando `lazy.nvim` para carga eficiente.
- **Atajos inteligentes**: Keymaps personalizados para flujo Python.
- **IA Integrada**: GitHub Copilot y Avante para asistencia de código con IA.
- **Gestor de archivos**: Yazi integrado para navegación rápida de archivos.
- **Notificaciones**: Sistema de notificaciones elegante con nvim-notify.
- **Detección automática**: Guess-indent para detectar estilo de indentación.
- **Vista previa de colores**: Colorizer para mostrar colores en tiempo real.

## 📦 Dependencias

### 🔧 Paquetes Principales

```bash
sudo pacman -S neovim python python-pip python-virtualenv ripgrep fd nodejs npm yazi
```

### 🐍 Python (recomendado)

```bash
pip install black isort flake8 pynvim
```

### 🌐 LSP y Herramientas

```bash
npm install -g pyright
```

### 🎨 Temas y Fuentes

- [Catppuccin](https://github.com/catppuccin/nvim)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [Yazi](https://github.com/sxyazi/yazi) - Gestor de archivos

## ⚡ Instalación Rápida

1. **Clona tu configuración**

```bash
cd ~/.config/
git clone https://github.com/hen-x/nvim-python.git nvim
```

2. **Instala dependencias**

```bash
sudo pacman -S neovim python python-pip python-virtualenv ripgrep fd nodejs npm yazi
pip install black isort flake8 pynvim
npm install -g pyright
```

3. **Abre Neovim y deja que los plugins se instalen automáticamente**

```bash
nvim
```

## 📁 Estructura Real de Archivos

```
~/.config/nvim/
├── init.lua
├── README.md
├── lua/
│   ├── config/
│   │   ├── autocmds.lua      # Autocomandos: highlight yank, resize splits, restore cursor, cerrar con 'q', etc.
│   │   ├── keymaps.lua       # Keymaps globales, navegación, buffers, tabs, resize, integración Hyprland
│   │   └── options.lua       # Opciones de Neovim: UI, rendimiento, indentación, búsqueda, etc.
│   ├── plugins/
│   │   ├── avante.lua            # IA avanzada (Avante + Copilot)
│   │   ├── colorizer.lua         # Vista previa de colores
│   │   ├── colorscheme.lua       # Catppuccin + Shades of Purple
│   │   ├── comment.lua           # Comentado rápido
│   │   ├── completion.lua        # Autocompletado (nvim-cmp, luasnip)
│   │   ├── copilot.lua           # GitHub Copilot
│   │   ├── dap.lua               # Debugging (nvim-dap)
│   │   ├── dashboard.lua         # Dashboard de inicio
│   │   ├── formatting.lua        # Formateo y linting (black, isort, ruff, etc)
│   │   ├── git.lua               # Integración Git
│   │   ├── guess-indent.lua      # Detección automática de indentación
│   │   ├── lazygit.lua           # LazyGit
│   │   ├── lsp.lua               # LSP (pyright, ruff, mason, etc)
│   │   ├── lualine.lua           # Statusline personalizada
│   │   ├── mini-indentscope.lua  # Visualización de indentación
│   │   ├── navigation.lua        # Navegación avanzada
│   │   ├── notify.lua            # Notificaciones
│   │   ├── session-management.lua# Gestión de sesiones
│   │   ├── telescope.lua         # Fuzzy finder
│   │   ├── treesitter.lua        # Syntax highlighting avanzada
│   │   ├── ui.lua                # Ajustes visuales
│   │   ├── visual-toggles.lua    # Toggles visuales
│   │   ├── which-key.lua         # Ayuda contextual de keymaps
│   │   ├── yazi.lua              # Integración con Yazi (gestor de archivos)
│   └── util/
│       └── colors.lua            # Paleta Catppuccin Mocha y utilidades de color
```


## 🔧 Plugins y Funcionalidades Clave

### 🧠 Inteligencia Artificial
- **Avante.nvim**: Asistente IA avanzado, integración nativa con Copilot, edición, explicación y generación de código/tests desde Neovim.
- **GitHub Copilot**: Sugerencias contextuales, autocompletado y panel interactivo.

### 📝 LSP, Autocompletado y Formateo
- **LSP**: pyright, ruff-lsp, marksman, css-lsp, bash-language-server, etc. (gestionados por mason.nvim)
- **Autocompletado**: nvim-cmp, luasnip, integración con LSP y snippets.
- **Formateo/Linting**: black, isort, ruff, prettier, stylua, sqlfluff, markdownlint, etc.

### 🐛 Depuración y Testing
- **nvim-dap**: Debugging interactivo para Python y otros lenguajes.
- **nvim-dap-ui**: UI visual para depuración.

### 🎨 UI y Experiencia Visual
- **Catppuccin**: Tema base Mocha, custom Shades of Purple.
- **lualine**: Statusline informativa y visual.
- **colorizer**: Vista previa de colores en tiempo real.
- **mini-indentscope**: Visualización de indentación.
- **notify**: Notificaciones animadas y limpias.

### 🔍 Búsqueda, Navegación y Git
- **telescope**: Fuzzy finder, búsqueda de archivos, símbolos, grep, proyectos, historial, etc.
- **yazi**: Gestor de archivos ultra-rápido, integración nativa.
- **git/lazygit**: Integración completa con Git y LazyGit.

### 🛠️ Utilidades y Automatización
- **which-key**: Ayuda contextual de todos los keymaps y atajos.
- **guess-indent**: Detección automática de indentación.
- **treesitter**: Syntax highlighting avanzada y parsing.
- **dashboard**: Pantalla de inicio personalizada.
- **session-management**: Gestión de sesiones y restauración.

## ⚙️ Configuración Detallada

- **init.lua**: Punto de entrada, carga módulos de configuración.
- **lua/config/**: Opciones, keymaps y autocmds personalizados.
- **lua/plugins/**: Configuración modular de cada plugin.
- **lua/util/colors.lua**: Utilidades para colores y pywal.
- **Formateo y linting**: Black/isort/flake8 integrados vía null-ls.
- **LSP**: Pyright configurado para Python, con autocompletado y diagnósticos.
- **DAP**: Debugging interactivo para Python.
- **Temas**: Catppuccin con personalización Shades of Purple.
- **IA**: GitHub Copilot y Avante para asistencia inteligente.

## 🚀 Uso Diario

- **Abrir proyecto Python**:
  ```bash
  cd ~/proyecto
  nvim
  ```
- **Formatear código**: `:Format`
- **Linting**: Automático al guardar
- **Depurar**: `:DapContinue`, `:DapToggleBreakpoint`
- **Buscar archivos**: `<leader>ff` (Telescope)
- **Buscar símbolos**: `<leader>fs`
- **Explorador de archivos**: `<leader>e` (Yazi)
- **GitHub Copilot**: `<Tab>` para aceptar sugerencias
- **Avante IA**: `<leader>aa` para asistencia con IA
- **Notificaciones**: `<leader>un` para limpiar notificaciones


## ⌨️ Keymaps y Atajos Destacados

### Líder y Navegación
- `<leader>` = `<Space>` (líder global)
- `<C-h/j/k/l>`: Moverse entre splits
- `<C-Up/Down/Left/Right>`: Redimensionar ventanas
- `<S-h/l>` o `[b`/`]b`: Cambiar buffer
- `<leader><tab><tab>`: Nueva pestaña
- `<leader><tab>l/f/o/d/...]`: Gestión avanzada de tabs

### IA y Asistencia
- `<Tab>` / `<C-l>`: Aceptar sugerencia de Copilot
- `<leader>aa`: Preguntar a Avante
- `<leader>ae`: Editar con Avante
- `<leader>axe`: Explicar código
- `<leader>axt`: Generar tests
- `<leader>cp`: Panel Copilot

### Código y LSP
- `gd`: Ir a definición
- `gr`: Referencias
- `<leader>ca`: Acciones de código
- `<leader>rn`: Renombrar símbolo
- `<leader>cf`: Formatear
- `<leader>ci`: Detectar indentación

### Depuración
- `<leader>db`: Toggle breakpoint
- `<leader>dc`: Continuar
- `<leader>di`: Step into
- `<leader>do`: Step over
- `<leader>dr`: REPL

### UI y Visual
- `<leader>uc`: Toggle colorizer
- `<leader>un`: Limpiar notificaciones
- `<leader>nh`: Historial notificaciones
- `<leader>tt`: Terminal
- `<leader>xx`: Diagnósticos (Trouble)

### Yazi (Gestor de Archivos)
- `<leader>e`: Abrir Yazi
- `<leader>E`: Abrir Yazi en cwd
- `<f1>`, `<c-v>`, `<c-x>`, `<c-t>`, `<c-s>`, `<c-q>`, `<c-y>`: Atajos nativos de Yazi

### Otros
- `<Esc>`: Limpiar búsqueda
- `j/k`: Navegación inteligente en líneas envueltas


## 🎯 Personalización y Lógica Avanzada

- **Plugins**: Añade/edita en `lua/plugins/` (estructura modular, cada plugin en su archivo)
- **Keymaps**: Todos los atajos globales y contextuales en `lua/config/keymaps.lua` (fácil de modificar)
- **Opciones**: Ajusta rendimiento, UI, indentación, búsqueda, etc. en `lua/config/options.lua`
- **Autocmds**: Automatizaciones y comportamientos inteligentes en `lua/config/autocmds.lua`
- **Colores**: Paleta Catppuccin Mocha y utilidades en `lua/util/colors.lua`
- **IA**: Configura Avante y Copilot en sus respectivos archivos de plugin
- **Yazi**: Integración y atajos en `lua/plugins/yazi.lua`
- **Notificaciones**: Personaliza animaciones y comportamiento en `lua/plugins/notify.lua`


## 🔍 Troubleshooting

- **LSP no funciona**: Verifica instalación de `pyright` y reinicia Neovim
- **Formateo no aplica**: Asegúrate de tener `black`, `isort`, `ruff` instalados
- **Errores de plugins**: Ejecuta `:Lazy sync` o revisa logs con `:messages`
- **Copilot no funciona**: Ejecuta `:Copilot auth` para autenticarse
- **Yazi no abre**: Verifica que yazi esté instalado con `yazi --version`
- **Notificaciones no aparecen**: Revisa configuración en `lua/plugins/notify.lua`
- **Colores no se muestran**: Activa colorizer con `<leader>uc`
- **Indentación incorrecta**: Usa `<leader>ci` para detectar automáticamente

## 📚 Referencias

- [Neovim](https://neovim.io/)
- [Pyright](https://github.com/microsoft/pyright)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [GitHub Copilot](https://github.com/github/copilot.vim)
- [Avante.nvim](https://github.com/yetone/avante.nvim)
- [Yazi](https://github.com/sxyazi/yazi)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim)
- [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua)

---


---

**Configuración mantenida por [h3n-x](https://github.com/h3n-x)**


