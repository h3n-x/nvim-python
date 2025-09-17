# 🐍 Configuración Neovim para Python en Arch Linux

> **Entorno de desarrollo optimizado para Python con Neovim, integración avanzada de plugins y automatización total.**

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
- **Integración con Pywal**: Colores adaptativos según tu wallpaper.
- **Atajos inteligentes**: Keymaps personalizados para flujo Python.

## 📦 Dependencias

### 🔧 Paquetes Principales

```bash
sudo pacman -S neovim python python-pip python-virtualenv ripgrep fd nodejs npm
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

## ⚡ Instalación Rápida

1. **Clona tu configuración**

```bash
cd ~/.config/
git clone https://github.com/hen-x/nvim-python.git nvim
```

2. **Instala dependencias**

```bash
sudo pacman -S neovim python python-pip python-virtualenv ripgrep fd nodejs npm
pip install black isort flake8 pynvim
npm install -g pyright
```

3. **Abre Neovim y deja que los plugins se instalen automáticamente**

```bash
nvim
```

## 📁 Estructura de Archivos

```
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── remove-colorcolumn.lua
├── avante.txt
├── avante1.txt
├── lua/
│   ├── config/
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── plugins/
│   │   ├── colorizer.lua
│   │   ├── colorscheme.lua
│   │   ├── completion.lua
│   │   ├── copilot.lua
│   │   ├── dap.lua
│   │   ├── formatting.lua
│   │   ├── lsp.lua
│   │   ├── lualine.lua
│   │   ├── nvim-tree.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── which-key.lua
│   └── util/
│       └── colors.lua
```

## 🔧 Plugins y Automatización

- **LSP**: `nvim-lspconfig`, `pyright`
- **Autocompletado**: `nvim-cmp`, `cmp-nvim-lsp`, `LuaSnip`
- **Formateo**: `null-ls.nvim` para black/isort/flake8
- **Depuración**: `nvim-dap`, `nvim-dap-ui`
- **UI**: `catppuccin`, `lualine`, `nvim-tree`, `indent-blankline`, `colorizer`
- **Fuzzy Finder**: `telescope.nvim`, `ripgrep`, `fd`
- **Git**: `gitsigns.nvim`
- **Copilot**: Integración con GitHub Copilot

## ⚙️ Configuración Detallada

- **init.lua**: Punto de entrada, carga módulos de configuración.
- **lua/config/**: Opciones, keymaps y autocmds personalizados.
- **lua/plugins/**: Configuración modular de cada plugin.
- **lua/util/colors.lua**: Utilidades para colores y pywal.
- **Formateo y linting**: Black/isort/flake8 integrados vía null-ls.
- **LSP**: Pyright configurado para Python, con autocompletado y diagnósticos.
- **DAP**: Debugging interactivo para Python.
- **Temas**: Catppuccin con integración pywal.

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
- **Explorador de archivos**: `<leader>e`
- **Comandos Copilot**: `<leader>cp`

## 🎯 Personalización Avanzada

- **Agregar plugins**: Edita `lua/plugins/` y reinicia Neovim
- **Modificar keymaps**: Edita `lua/config/keymaps.lua`
- **Cambiar tema**: Edita `lua/plugins/colorscheme.lua`
- **Integrar nuevos linters**: Añade en `lua/plugins/formatting.lua`

## 🔍 Troubleshooting

- **LSP no funciona**: Verifica instalación de `pyright` y reinicia Neovim
- **Formateo no aplica**: Asegúrate de tener `black` y `isort` instalados
- **Errores de plugins**: Ejecuta `:Lazy sync` o revisa logs con `:messages`
- **Colores no cambian**: Verifica integración de pywal y recarga el tema

## 📚 Referencias

- [Neovim](https://neovim.io/)
- [Pyright](https://github.com/microsoft/pyright)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [GitHub Copilot](https://github.com/github/copilot.vim)

---

**Creado por [hen-x](https://github.com/hen-x)**

> 🚀 **¡Disfruta de un entorno Python productivo y elegante con Neovim!** 🚀
