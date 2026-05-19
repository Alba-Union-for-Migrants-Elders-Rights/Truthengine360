# Installing Claude Code on Windows

This guide walks through installing Claude Code on Windows using PowerShell.
Claude Code is included for free with a Pro or Max subscription, but it does
**not** work on the free tier.

## Step 3: Run the Claude Code installer

Inside PowerShell, paste this single line and press Enter:

```powershell
# Downloads the official installer from claude.ai and runs it.
# `irm` fetches the script; `iex` executes it. No admin rights needed.
irm https://claude.ai/install.ps1 | iex
```

If you somehow end up in CMD instead of PowerShell and get an error about
`irm` not being recognized, the CMD equivalent is:

```cmd
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

The installer will download the Claude Code binary, place it inside a hidden
folder in your user directory (`C:\Users\YourName\.local\bin`), and attempt
to add that folder to your PATH so you can run `claude` from anywhere.

## Step 4: Close the terminal and open a fresh one

This step looks trivial but it's important. PATH changes only take effect for
new terminal sessions, so the window you ran the installer in still doesn't
know about the new `claude` command. Close it completely, then open a new
PowerShell window.

Test it with these two commands:

```powershell
claude --version    # Should print a version number like 2.x.x
claude doctor       # Runs a health check on your install
```

The `claude doctor` command is worth running every time you set up a new
machine — it tells you what's missing, what's misconfigured, and what's
working, all in one report.

## The most likely thing that goes wrong

If you type `claude --version` and get back
`The term 'claude' is not recognized as the name of a cmdlet...`, you've hit
the most common Windows install issue. It means the install succeeded but the
folder containing `claude.exe` isn't in your PATH. The fix is a single
command in PowerShell:

```powershell
# Adds the install folder to your user PATH, permanently.
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$env:USERPROFILE\.local\bin", [EnvironmentVariableTarget]::User)

# Also makes it work in this current session without restarting.
$env:PATH = "$env:PATH;$env:USERPROFILE\.local\bin"
```

Close and reopen PowerShell one more time, and `claude --version` should now
work.

## Step 5: Log in

The first time you run `claude` (not `claude --version`, just `claude`)
inside any folder, it'll open a browser window asking you to sign in to your
Anthropic account. Use the same email you use for Claude.ai — Claude Code is
included for free with a Pro or Max subscription, but as mentioned above, it
does not work on the free tier. Once you've signed in, Claude Code remembers
you and you won't have to do it again on that machine.

## Step 6: Try it on a real git repo

Now for the part you actually came here for. Navigate to a folder that's
already a git repository (or make a new one), then start Claude:

```powershell
# Move into an existing repo, or make a new one to practice on
cd $HOME\Projects\my-repo

# Optional: create a brand-new repo to play with safely
mkdir $HOME\Projects\claude-test
cd $HOME\Projects\claude-test
git init
"# Test file" | Out-File README.md

# Launch Claude Code in this folder
claude
```

## Step 7: Clone an existing repo and run Claude inside it

```powershell
# Move to wherever you want the repo to live
cd $HOME\Projects

# Clone it (works for both public and private repos if you're authenticated)
git clone https://github.com/Gama0218-lgtm/NELA.git
cd NELA

# Start Claude Code inside the repo
claude
```
