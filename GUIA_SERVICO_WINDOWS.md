# Instalação do Serviço Windows (NSSM)

Grupo Líder Supermercados - Apresentação de Resultados

---

## 📋 Pré-requisitos

- ✅ Windows 7 ou superior (2008, 2012, 2016, 2019, 2022)
- ✅ PowerShell com privilégios de Administrador
- ✅ Python 3.7+ instalado
- ✅ NSSM (Non-Sucking Service Manager) baixado

---

## 🚀 Instalação Passo a Passo

### Passo 1: Baixar NSSM

1. Acesse: https://nssm.cc/download
2. Baixe a versão correspondente (geralmente 2.24)
3. Descompacte em `C:\nssm\`

**Estrutura esperada:**
```
C:\nssm\
├── nssm.exe
├── nssm-2.24-101-g897c7047.exe
└── (outros arquivos)
```

### Passo 2: Executar Script de Instalação

1. Abra **PowerShell como Administrador**
   - Pesquise "PowerShell" no Windows
   - Clique com direito → "Executar como administrador"

2. Navegue até a pasta do projeto:
   ```powershell
   Set-Location "D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
   ```

3. Execute o instalador nativo do Windows (duplo clique ou pelo PowerShell):
   ```powershell
   & ".\INSTALAR_SERVICO_WINDOWS.bat"
   ```

4. Aguarde a instalação concluir

> Como a instalação está sendo executada diretamente no servidor, use o diretório local `D:`:
> ```powershell
> Set-Location "D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
> .\INSTALAR_SERVICO_WINDOWS.bat
> ```

### Passo 3: Verificar Instalação

Após a instalação, o script mostrará:
```
✅ SUCESSO!

Serviço instalado e executando:
  Status: Running
  Tipo: Automatic
   Porta: 127.0.0.1:5001
```

Antes da instalação, no PowerShell, instale as dependências com:

```powershell
Set-Location "D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
& "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe" -m pip install -r ".\backend\requirements.txt"
```
---

## 🔧 Gerenciando o Serviço

### Via PowerShell (Recomendado)

**Iniciar o serviço:**
```powershell
Start-Service -Name GrupoLider-ExportPPT
```

**Parar o serviço:**
```powershell
Stop-Service -Name GrupoLider-ExportPPT
```

**Verificar status:**
```powershell
Get-Service -Name GrupoLider-ExportPPT
```

**Remover o serviço:**
```powershell
& 'C:\nssm\nssm.exe' remove GrupoLider-ExportPPT confirm
```

### Via Interface Gráfica (services.msc)

1. Pressione **Win + R**
2. Digite `services.msc`
3. Pressione Enter
4. Procure por **"GrupoLider-ExportPPT"**
5. Clique com direito para:
   - Iniciar/Parar
   - Propriedades (configurar tipo de startup)
   - Remover

---

## 📊 Usando a Apresentação

### Com o Serviço Rodando

1. Abra a apresentação no navegador:
   ```
   Navegue até a pasta: site/index.html
   ```

2. Clique no botão **"📊 Exportar PPT"**

3. O arquivo será baixado automaticamente

### Verificar Porta 5001

Para confirmar que a API da apresentação está ativa:
```powershell
# Encontrar processo usando porta 5001
netstat -ano | findstr :5001

Invoke-WebRequest "http://127.0.0.1:5001/api/health" -UseBasicParsing
```

A porta `5000` pertence a outro sistema e não deve ser alterada.

---

## 🐛 Solução de Problemas

### Erro: "Script requer privilégios de Administrador"
- Solução: Abra PowerShell como Administrador (não é o bastante clicar em abrir)

### Erro: "não está assinado digitalmente" ou "UnauthorizedAccess"
- Use o instalador `.bat`, que não depende da política de execução do PowerShell:
   ```powershell
   Set-Location "D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
   .\INSTALAR_SERVICO_WINDOWS.bat
   ```

### Erro: "NSSM não encontrado"
- Verifique se NSSM está em: `C:\nssm\nssm.exe`
- Baixe em: https://nssm.cc/download

### Erro: "Porta 5001 já em uso"
- Verifique com: `netstat -ano | findstr :5001`
- Não altere a porta 5000, pois ela pertence a outro sistema.

### Serviço instalado, mas permanece parado
- O serviço usa um launcher CMD para preservar os caminhos com espaços. Reinstale somente este serviço executando o instalador:
   ```powershell
   Set-Location 'D:\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao'
   .\INSTALAR_SERVICO_WINDOWS.bat
   ```
- Confirme a configuração do serviço:
   ```powershell
   & 'C:\nssm\nssm.exe' get GrupoLider-ExportPPT Application
   & 'C:\nssm\nssm.exe' get GrupoLider-ExportPPT AppParameters
   & 'C:\nssm\nssm.exe' get GrupoLider-ExportPPT AppDirectory
   ```

### Serviço não inicia
- Verifique logs em: `Gerenciador de Eventos do Windows`
- Execute manualmente para ver erro: `python backend/app/main.py`

### Conexão recusada ao exportar
- Verifique se serviço está rodando: `Get-Service -Name GrupoLider-ExportPPT`
- Inicie se necessário: `Start-Service -Name GrupoLider-ExportPPT`

---

## ✨ Comportamento do Serviço

### Auto-restart Habilitado
- Se o servidor cair, NSSM o reiniciará automaticamente
- Delay de reinício: 5 segundos
- Útil para recuperação de erros

### Startup Automático
- Quando o Windows iniciar, o serviço iniciará automaticamente
- Não precisa fazer nada manual
- Apresentação sempre disponível

### Logs
- Verifique em: `Visualizador de Eventos` → `Windows Logs` → `Application`
- Procure por eventos do NSSM

---

## 📝 Referências

- **NSSM**: https://nssm.cc/
- **PowerShell Services**: https://docs.microsoft.com/powershell/
- **Python**: https://www.python.org/

---

## 🎯 Próximos Passos

1. ✅ NSSM instalado
2. ✅ Serviço criado e rodando
3. 📌 Abra a apresentação e teste o botão "Exportar PPT"
4. 📌 Verifique se arquivo é gerado corretamente

Qualquer dúvida, execute novamente o script de instalação ou consulte os logs.
