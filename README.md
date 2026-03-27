# Binance Skills Pack

一键安装币安全部 Skills（共 23 个），覆盖现货、合约、期权、链上分析、Meme 追踪等。

## 包含 Skills

### CEX 交易类（需 API Key）

| Skill | 说明 |
|---|---|
| spot | 现货行情与交易 |
| derivatives-trading-usds-futures | U 本位合约 |
| derivatives-trading-coin-futures | 币本位合约 |
| derivatives-trading-options | 期权交易 |
| derivatives-trading-portfolio-margin | 组合保证金 |
| derivatives-trading-portfolio-margin-pro | 组合保证金 Pro |
| margin-trading | 杠杆交易（借贷/OCO/OTO） |
| algo | 算法交易（冰山/TWAP） |
| convert | 闪兑 |
| simple-earn | 简单赚币 |
| fiat | 法币交易 |
| p2p | P2P/C2C 交易 |
| assets | 资产管理（充值/提现/余额） |
| sub-account | 子账户管理 |
| vip-loan | VIP 借贷 |

### 链上/Web3 类（无需 API Key）

| Skill | 说明 |
|---|---|
| crypto-market-rank | 市场排行榜（趋势/聪明钱/Meme） |
| trading-signal | 聪明钱买卖信号 |
| query-token-info | 代币详情查询 |
| query-address-info | 钱包地址洞察 |
| query-token-audit | 合约安全审计 |
| meme-rush | Meme 代币速通 |
| square-post | 发布币安广场内容 |
| binance-tokenized-securities-info | 代币化美股数据 |

## 安装

### Windows

```cmd
# 方式一：批处理
install.bat

# 方式二：PowerShell（推荐）
powershell -ExecutionPolicy Bypass -File install.ps1
```

### macOS / Linux

```bash
chmod +x install.sh
./install.sh
```

## 配置

### 方式一：环境变量

```bash
export BINANCE_API_KEY=your-api-key
export BINANCE_SECRET=your-api-secret
export BINANCE_TESTNET=1   # 测试网，上线前设为 0
```

### 方式二：凭据文件

将 `credentials/binance.json.example` 复制为 `credentials/binance.json` 并填入 API Key。

```bash
cp credentials/binance.json.example credentials/binance.json
```

### 获取 API Key

1. 登录 [币安](https://www.binance.com)
2. 进入 **API 管理**
3. 创建 API Key，**只开启交易权限，禁止提币**
4. 建议绑定 IP 白名单

## 安全提醒

- **永远不要开启提币权限**
- 优先使用**测试网**验证
- API Key 建议绑定 IP
- 不要将密钥提交到 Git 仓库

## 自定义安装

编辑 `skills.txt`，删除不需要的 Skill，每行一个。

```bash
# 示例：只安装现货行情和合约
spot
derivatives-trading-usds-futures
```

然后重新运行安装脚本。
