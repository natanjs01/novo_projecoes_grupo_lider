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
   cd "\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
   ```

3. Libere scripts somente nesta janela do PowerShell:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
   ```

4. Execute o script:
   ```powershell
   & ".\INSTALAR_SERVICO_WINDOWS.ps1" -PythonPath "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
   ```

5. Aguarde a instalação concluir

> A opção `-Scope Process` vale somente para a janela atual e não altera permanentemente a política do Windows.

> Se o prompt estiver em `C:\Users\Idcontroller`, use o caminho completo:
> ```powershell
> & "\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao\INSTALAR_SERVICO_WINDOWS.ps1" -PythonPath "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
> ```

### Passo 3: Verificar Instalação

Após a instalação, o script mostrará:
```
✅ SUCESSO!

Serviço instalado e executando:
  Status: Running
  Tipo: Automatic
  Porta: 127.0.0.1:5000
```

Antes da instalação, no PowerShell, instale as dependências com:

```powershell
Set-Location "\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
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

### Verificar Porta 5000

Se tiver erro de porta em uso:
```powershell
# Encontrar processo usando porta 5000
netstat -ano | findstr :5000

# Se NSSM estiver usando, pode parar assim:
Stop-Service -Name GrupoLider-ExportPPT -Force
```

---

## 🐛 Solução de Problemas

### Erro: "Script requer privilégios de Administrador"
- Solução: Abra PowerShell como Administrador (não é o bastante clicar em abrir)

### Erro: "não está assinado digitalmente" ou "UnauthorizedAccess"
- Execute o PowerShell como Administrador
- Na pasta do projeto, rode:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
   Set-Location "\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao"
   & ".\INSTALAR_SERVICO_WINDOWS.ps1" -PythonPath "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
   ```
- Alternativamente, execute diretamente:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File "\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao\INSTALAR_SERVICO_WINDOWS.ps1" -PythonPath "C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
   ```

### Erro: "NSSM não encontrado"
- Verifique se NSSM está em: `C:\nssm\nssm.exe`
- Baixe em: https://nssm.cc/download

### Erro: "Porta 5000 já em uso"
- Outro serviço está usando a porta
- Verifique com: `netstat -ano | findstr :5000`
- Mude a porta em: `backend/app/main.py` (última linha)

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
