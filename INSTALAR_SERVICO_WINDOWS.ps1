<#
.SYNOPSIS
Instala o servidor de exportação PPT como serviço Windows usando NSSM
Grupo Líder Supermercados - Apresentação

.DESCRIPTION
Script que:
1. Verifica permissões de Administrador
2. Instala/configura o serviço via NSSM
3. Define startup automático e auto-restart
4. Inicia o serviço
5. Valida instalação

.NOTES
Requer: NSSM instalado em C:\nssm\nssm.exe
#>

param(
    [string]$NSsmPath = "C:\nssm\nssm.exe",
    [string]$PythonPath = "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe",
    [string]$ProjectRoot = "D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao",
    [string]$ServiceName = "GrupoLider-ExportPPT",
    [string]$DisplayName = "Grupo Líder - Exportação PPT",
    [string]$StartupType = "Automatic"
)

# ========== FUNÇÃO: Verificar Admin ==========
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# ========== VALIDAÇÕES INICIAIS ==========
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Instalador de Serviço Windows (NSSM)" -ForegroundColor Green
Write-Host "Grupo Líder Supermercados" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar admin
if (-not (Test-IsAdmin)) {
    Write-Host "❌ ERRO: Script requer privilégios de Administrador!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solução:" -ForegroundColor Yellow
    Write-Host "  1. Abra PowerShell como Administrador" -ForegroundColor White
    Write-Host "  2. Execute novamente este script" -ForegroundColor White
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ Privilégios de Administrador confirmados" -ForegroundColor Green

# Verificar NSSM
if (-not (Test-Path $NSsmPath)) {
    Write-Host "❌ NSSM não encontrado em: $NSsmPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solução:" -ForegroundColor Yellow
    Write-Host "  1. Baixe NSSM em: https://nssm.cc/download" -ForegroundColor White
    Write-Host "  2. Descompacte em C:\nssm\" -ForegroundColor White
    Write-Host "  3. Execute novamente este script" -ForegroundColor White
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ NSSM encontrado: $NSsmPath" -ForegroundColor Green

# Verificar raiz do projeto
if (-not (Test-Path $ProjectRoot)) {
    Write-Host "❌ Projeto não encontrado em: $ProjectRoot" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ Projeto: $ProjectRoot" -ForegroundColor Green

# Verificar Python
if (-not (Test-Path $PythonPath)) {
    Write-Host "❌ Python não encontrado em: $PythonPath" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ Python: $PythonPath" -ForegroundColor Green

# Verificar script de backend
$backendScript = Join-Path $ProjectRoot "backend\app\main.py"
if (-not (Test-Path $backendScript)) {
    Write-Host "❌ Script não encontrado: $backendScript" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ Script: $backendScript" -ForegroundColor Green
Write-Host ""

# ========== INFORMAÇÕES DO SERVIÇO ==========
Write-Host "Configurando Serviço..." -ForegroundColor Yellow
Write-Host "  Nome: $ServiceName" -ForegroundColor White
Write-Host "  Exibição: $DisplayName" -ForegroundColor White
Write-Host "  Startup: $StartupType" -ForegroundColor White
Write-Host "  Auto-restart: Habilitado" -ForegroundColor White
Write-Host "  Porta: 127.0.0.1:5000" -ForegroundColor White
Write-Host ""

# ========== REMOVER SERVIÇO EXISTENTE ==========
Write-Host "Verificando serviço existente..." -ForegroundColor Yellow
$existingService = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

if ($existingService) {
    Write-Host "  Serviço já existe. Removendo..." -ForegroundColor White
    
    if ($existingService.Status -eq 'Running') {
        Write-Host "  Parando serviço..." -ForegroundColor White
        Stop-Service -Name $ServiceName -Force -NoWait
        Start-Sleep -Seconds 2
    }
    
    & $NSsmPath remove $ServiceName confirm
    Write-Host "  ✓ Serviço removido" -ForegroundColor Green
    Start-Sleep -Seconds 1
}
else {
    Write-Host "  Novo serviço será criado" -ForegroundColor Green
}

Write-Host ""

# ========== INSTALAR SERVIÇO ==========
Write-Host "Instalando serviço..." -ForegroundColor Yellow

$arguments = @(
    "install",
    $ServiceName,
    $PythonPath,
    $backendScript
)

& $NSsmPath $arguments
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao instalar serviço!" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✓ Serviço instalado" -ForegroundColor Green

# ========== CONFIGURAÇÕES NSSM ==========
Write-Host ""
Write-Host "Configurando parâmetros..." -ForegroundColor Yellow

# Diretório de trabalho
Write-Host "  Definindo diretório de trabalho..." -ForegroundColor White
& $NSsmPath set $ServiceName AppDirectory $ProjectRoot
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Diretório de trabalho: $ProjectRoot" -ForegroundColor Green
}

# Startup type
Write-Host "  Definindo tipo de startup..." -ForegroundColor White
$startupTypeMap = @{
    "Automatic" = "SERVICE_AUTO_START"
    "Manual" = "SERVICE_DEMAND_START"
    "Disabled" = "SERVICE_DISABLED"
}
$serviceType = $startupTypeMap[$StartupType]
cmd /c "sc config $ServiceName start=$serviceType"
Write-Host "  ✓ Startup: $StartupType" -ForegroundColor Green

# Descrição do serviço
Write-Host "  Definindo descrição..." -ForegroundColor White
& $NSsmPath set $ServiceName Description "Servidor Flask para exportação de apresentações em PowerPoint - Grupo Líder Supermercados"
Write-Host "  ✓ Descrição definida" -ForegroundColor Green

# Auto-restart
Write-Host "  Habilitando auto-restart..." -ForegroundColor White
& $NSsmPath set $ServiceName AppRestart Restart
Write-Host "  ✓ Auto-restart habilitado (reinicia se cair)" -ForegroundColor Green

# Delay de restart
& $NSsmPath set $ServiceName AppRestartDelay 5000
Write-Host "  ✓ Delay de restart: 5 segundos" -ForegroundColor Green

Write-Host ""

# ========== INICIAR SERVIÇO ==========
Write-Host "Iniciando serviço..." -ForegroundColor Yellow
Start-Service -Name $ServiceName -ErrorAction SilentlyContinue

Start-Sleep -Seconds 3

# ========== VALIDAR ==========
$service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

if ($service.Status -eq 'Running') {
    Write-Host ""
    Write-Host "✅ SUCESSO!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Serviço instalado e executando:" -ForegroundColor Green
    Write-Host "  Status: $($service.Status)" -ForegroundColor White
    Write-Host "  Tipo: $($service.StartType)" -ForegroundColor White
    Write-Host "  Porta: 127.0.0.1:5000" -ForegroundColor White
    Write-Host ""
    Write-Host "Próximos passos:" -ForegroundColor Yellow
    Write-Host "  1. Abra a apresentação no navegador" -ForegroundColor White
    Write-Host "  2. Clique em '📊 Exportar PPT'" -ForegroundColor White
    Write-Host "  3. Arquivo será baixado automaticamente" -ForegroundColor White
    Write-Host ""
}
else {
    Write-Host ""
    Write-Host "⚠️  Serviço instalado mas não está rodando" -ForegroundColor Yellow
    Write-Host "  Status: $($service.Status)" -ForegroundColor White
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  • Verifique logs em: C:\nssm\$ServiceName" -ForegroundColor White
    Write-Host "  • Inicie manualmente:" -ForegroundColor White
    Write-Host "    Start-Service -Name $ServiceName" -ForegroundColor Cyan
    Write-Host ""
}

# ========== COMANDOS ÚTEIS ==========
Write-Host ""
Write-Host "Comandos úteis para gerenciar o serviço:" -ForegroundColor Magenta
Write-Host ""
Write-Host "Iniciar:" -ForegroundColor White
Write-Host "  Start-Service -Name $ServiceName" -ForegroundColor Cyan
Write-Host ""
Write-Host "Parar:" -ForegroundColor White
Write-Host "  Stop-Service -Name $ServiceName" -ForegroundColor Cyan
Write-Host ""
Write-Host "Status:" -ForegroundColor White
Write-Host "  Get-Service -Name $ServiceName" -ForegroundColor Cyan
Write-Host ""
Write-Host "Remover serviço:" -ForegroundColor White
Write-Host "  & 'C:\nssm\nssm.exe' remove $ServiceName confirm" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ver logs:" -ForegroundColor White
Write-Host "  Abra services.msc pelo Win+R para ver os logs" -ForegroundColor Cyan
Write-Host ""

Read-Host "Pressione Enter para sair"
