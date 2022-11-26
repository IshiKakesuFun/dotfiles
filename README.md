# Personal dotfiles for Windows 2

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/IshiKakesuFun/dotfiles)

- [Personal dotfiles for Windows 2](#personal-dotfiles-for-windows-2)
- [Prerekvizity](#prerekvizity)
  - [Scoop CLI installer](#scoop-cli-installer)
  - [Instalace nástrojů pro vývoj](#instalace-nástrojů-pro-vývoj)
  - [Git](#git)
  - [NVM manažer verzí node.js a npm](#nvm-manažer-verzí-nodejs-a-npm)
  - [Node.js a npm](#nodejs-a-npm)
  - [Nerd fonty](#nerd-fonty)
  - [Make, CMake, gcc, VC redist, WGet, CURL, 7-Zip a cacert](#make-cmake-gcc-vc-redist-wget-curl-7-zip-a-cacert)
  - [Docker](#docker)
- [Instalace neovim](#instalace-neovim)
  - [Prerekvizity](#prerekvizity-1)
    - [Symlinky do konfiguračních adresářů](#symlinky-do-konfiguračních-adresářů)
    - [Nástroje pro vyhledávání fzf, fd, ripgrep](#nástroje-pro-vyhledávání-fzf-fd-ripgrep)
  - [Instalace](#instalace)
  - [Po instalaci](#po-instalaci)
    - [Poskytovatele pro Python, Ruby, NodeJS a Perl](#poskytovatele-pro-python-ruby-nodejs-a-perl)

# Prerekvizity

## Scoop CLI installer

CLI installer [Scoop](https://scoop.sh/) instaluje známé oblíbené aplikace 
(včetně linuxových) jako *partable* do separatních podsložek s pokud možno 
minimálními nároky na uživatele.

- potlačuje vyskakovací okna oprávnění
- potlačuje gui instalační wizardy
- zabraňuje nadměrnému množství položek v PATH 
- zabraňuje neočekávaným nechtěným vedlejším efektům spojeným s instalací 
  resp. odinstalací programů
- vyhledává a automaticky instaluje závislosti
- provádí všechna dodatečná nastavení tak, aby programu mohl ihned běžet


- [x] [Scoop](https://github.com/ScoopInstaller/Install#readme) nainstaluj 
  z konzole PowerShellu, dle uvedeného postupu s nastavením práva na volání 
  vzdáleného scriptu.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

- [x] **Scoop** se defaultně nainstaluje do uživaltelské složky 
  `C:\Users\<YOUR USERNAME>\scoop` následujícím scriptem.

```powershell
irm get.scoop.sh | iex
```

- [x] Přidej další *buckets*, které budeš později používat.

```powershell
scoop bucket add extras versions nerd-fonts
```

- [x] Po instalaci a přidání *buckets* zkontroluj a případně zaktualizuj nové 
  verze 

```powershell
scoop status
scoop update
```

- [x] Zavři PowerShell konzoli, aby se projevily změny.

> **Prevence přetečení limitu 260 znaků pro** `PATH` **proměnnou**
> 
> Instalace zavádí do `PATH` cesty budoucích aplikací, které jsou relativně 
> dlouhé. Je pravděpodobné, že by mohlo dojít k problémům s přetečením limitu 
> 260 znaků. Proveď opatření povolující dlouhé cesty.
> 
> - [x] Otevři PowerShell jako administrátor. Nastav podporu dlouhých cest 
> v registrech.
>
> ```powershell
> Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem\" -Name "LongPathsEnabled" -Value 1
> ```
>
> - [x] Otevři *Local Group Policy Editor* a nastav níže uvedenou proměnnou na 
> `Enabled`
>
> ``` 
> Local Computer Policy 
> └───Computer Configuration 
>     └───Administrative templates
>         └───System  
>             └───Filesystem  
>                 └───Enable Win32 long paths
> ```

## Instalace nástrojů pro vývoj

Obecně lze říci, že většina aplikací pro vývoj bude vyžadovat instalci pod
administrátorským účtem, proto pro další postup použij vždy **PowerShell konzoli
spuštěnou pod administrátorským účtem**, pokud explicitně neuvedu jinak.

## Git

- [x] [Git](https://git-scm.com/) nainstaluj uvedeným příkazem. Zkontroluj verzi
  a nastav doporučenou konfiguraci.

```cmd
scoop install git
git -v

git config --global credential.helper manager-core
```

## NVM manažer verzí node.js a npm

- [x] Otevři konzoli a nainstaluj *scoopem* 
  [nvm](https://github.com/coreybutler/nvm-windows).

```cmd
scoop install nvm
```

- [x] Zavři a znovu otevři konzoli, aby se projevilo nastavení proměnných 
  `%NVM_HOME%` a `%NVM_SYMLINK%` a jejich doplnění do `%PATH%`.

## Node.js a npm

- [x] Nainstaluj LTS verzi [node.js](https://nodejs.org) a nastav ji jako 
  aktálně používanou. Vše ověříš vylistováním nainstalovaných verzí a kontrolou 
  nalinkované verze

```cmd
nvm install lts

nvm use lts

nvm list
node -v
npm -v
```

## Nerd fonty

- [x] [Nerd-fonts](https://www.nerdfonts.com) tvoří smostatný 
  [bucket](https://github.com/matthewjberger/scoop-nerd-fonts), který byl již 
  přidán, ale musíš pro něj ještě vygenerovat resp. přegenerovat *manifest*.

```powershel
cd $home\scoop\buckets\nerd-fonts
.\bin\generate-manifests.ps1 -OverwriteExisting
```

- [x] Nainstaluj vybraný font
  
```powershell
scoop install JetBrainsMono-NF
scoop install JetBrainsMono-NF-Mono
```

Zavři a znovu otevři konzoli

## Make, CMake, gcc, VC redist, WGet, CURL, 7-Zip a cacert

Některé aplikace, resp. jejich pluginy, nedistribuují buildy pro cílový OS či
architekturu a v rámci instalačního postupu se musí zkompilovat a sestavit ze
zdrojových kódů. K tomu je zapotřebí nainstalovat příslušné nástroje, aby byl
tzv. *build/toolchain* připraven.

- [x] Nainstaluj *toolchain* aplikace

```powershell
scoop install make cmake vcredist2022 gcc wget curl 7zip
```

*Cacert* bude nainstalován jako závislost pro *Wget* automaticky. 
Prověř instalaci výpisem. 

```powershell
scoop list
```

Zavři a znovu otevři konzoli.

## Docker

- [x] Nainstaluj Docker.

> Důležité: Takto nainstalovaný *docker* podporuje jen kontajnery pro OS hosta (Windows).

```powershell
scoop install docker
```

- [x] Zaveď službu *Docker Engine*.

```powershell
dockerd --register-service
```

- [x] Otevři *Services* a službu *Docker Engine* nastartuj.

Ověř funkčnost vypsáním systémových informací. Zavři a znovu otevři konzoli.

```powershell
docker system info
```

Zavři a znovu otevři konzoli.

# Instalace [neovim](https://neovim.io/)

Pokud chci používat nejnovější verzi 
[neovim](https://github.com/neovim/neovim) musím zvolit 
[neovim-nightly](https://github.com/neovim/neovim/releases/tag/nightly) 
z *bucketu* [versions](https://github.com/ScoopInstaller/Versions).

## Prerekvizity

### Symlinky do konfiguračních adresářů

- [x] Kofigurční adresáře jsou součástí repozitáře. V prostředí windows není 
  možné využít `XDG` proměnné prostředí, tak využiji *symlinky*.

```powershell
$repo = "$home\repos\github.com\IshiKakesuFun\dotfiles";

$lnvim = "$env:LOCALAPPDATA\nvim";
$nvim = $repo + "\.config\nvim";

if (Test-Path "$lnvim") {
    (Get-Item "$lnvim").Delete();
}
New-Item -ItemType SymbolicLink -Path "$lnvim" -Target "$nvim";
```

### Nástroje pro vyhledávání fzf, fd, ripgrep

- [x] Nainstaluj pomocné nástroje pro vyhledávní souborů a jejich obsahu.

```powershell
scoop install fd fzf ripgrep
scoop list
```

## Instalace

- [x] Nainstaluj *nightly build*

```powershell
scoop install neovim-nightly
```

## Po instalaci

V prostředí Windows pouštěj *neovim GUI* klienta `nvim-qt`. 
Po instalaci použij parametr `--clean`, aby se nezavedla konfigurace z repozitáře,
která obsahuje i nastavení vyžadující dosud nenainstalované části.

```powershell
nvim-qt -- --clean
```

V *neovimu* proveď příkaz, který analyzuje stav instalace aplikace, zejména
postytovatelů podporovaných jazyků
```
:checkhealth
```

### Poskytovatele pro Python, Ruby, NodeJS a Perl

Funkce *neovimu* lze rozšiřovat i pluginy resp. moduly od ruzných 
poskytovatelů. Příslušný *balíček* podporující neovim doinstaluj odpovídajícím
správcem balíčků daného jazyka.

- [x] Nainstaluj *NodeJS* poskytovatele pro neovim jako globální balíček.

```powershell
npm install -g neovim
npm -g list
```

- [x] Než nainstaluješ *Python* poskytovatele pro neovim, musíš nainstalovat
  jazyk Python, který automaticky nainstaluje *dark*, a posléze instalátor
  balíčku *pip*.

```powershell
scoop install python
python --version
```
- [x] Scoop nenainstaluje dobře script pro instalátor *pip*. Nainstaluj ho ručně
stažením a spuštěním instalčného scriptu v adresáři `shims`.

```powershell
cd $home\scoop\shims
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

pip --version
pip list
```

- [x] Nainstaluj *Python* poskytovatele pro neovim.

```powershell
python -m pip install --user --upgrade pynvim

pip list
```

Ostatní poskytovatele se díky konfiguraci neboudou kontrolovat.

```lua
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
```

- [ ] Nainstaluj *Ruby* poskytovatele pro neovim, až když bude potřeba.

- [ ] Nainstaluj *Perl* poskytovatele pro neovim, až když bude potřeba.

- [ ] Spusť *neovim* standardně

```powershel
nvim-qt
```

TODO