# GTX 1650 开发利用指南

> GPU: NVIDIA GeForce GTX 1650 · 4GB GDDR5 · Turing · 896 CUDA Cores · NVENC

## 能力评估

| 方向 | 适合性 | 说明 |
|------|:---:|------|
| CUDA 开发 | ✅ | 4GB 够入门模型训练（PyTorch/TensorFlow） |
| 本地 LLM | ✅ | Ollama 可跑 1.5B-7B 量化模型 |
| nanoGPT | ✅ | Karpathy 的训练脚本完全能跑 |
| NVENC 编码 | ✅ | Turing 代 NVENC，画质不错 |
| 终端 GPU 加速 | ✅ | WezTerm/WinTerm 自动启用 |
| 浏览器加速 | ✅ | NVIDIA 控制面板可强制独显 |
| WSL2 GPU | ✅ | 需要对应驱动 |
| 游戏 | ⚠️ | DLSS 不支持（1650 无 Tensor Core） |

## 开发环境搭建

### 1. CUDA Toolkit

```powershell
# 检查当前驱动支持的 CUDA 版本
nvidia-smi

# 下载 CUDA Toolkit（选择与驱动匹配的版本）
# https://developer.nvidia.com/cuda-downloads
```

### 2. cuDNN

从 NVIDIA Developer 下载对应 CUDA 版本的 cuDNN，解压到 CUDA 安装目录。

### 3. WSL2 GPU 直通

```powershell
# WSL2 内安装 NVIDIA 驱动（无需在 Windows 侧额外操作）
# WSL2 自动共享 Windows 的 GPU 驱动
wsl --install -d Ubuntu
# 进入 WSL2 后：
nvidia-smi  # 应该能看到 GTX 1650
```

### 4. Ollama 本地 LLM

```powershell
winget install Ollama.Ollama
ollama serve  # 启动服务

# 推荐的模型（4GB 显存能跑的）
ollama pull qwen2.5:3b       # 阿里千问 3B
ollama pull llama3.2:3b      # Meta Llama 3.2 3B
ollama pull phi3:mini        # 微软 Phi-3 Mini
ollama pull gemma2:2b        # Google Gemma 2 2B
```

### 5. NVENC 硬件编码（FFmpeg）

```powershell
scoop install ffmpeg
# 检查 NVENC 可用：
ffmpeg -encoders 2>&1 | Select-String "nvenc"
```

## 注意事项

- 4GB 显存跑 7B 模型需要 Q4_K_M 或更低量化
- 同时跑 Ollama + Docker + VS Code 时注意 16GB 系统内存
- 定期用 `nvidia-smi` 检查显存使用