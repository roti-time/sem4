# Organization Name - Developer Guidelines

Welcome to our organization! This document outlines the guidelines and best practices for collaborating on projects within our organization.

## Getting Started

### Installing Git

#### Windows

1. **Download Git**: Visit the official Git website (https://git-scm.com/) and download the latest version of Git for Windows.

2. **Run the installer**: Double-click the downloaded installer and follow the on-screen instructions. Leave the default settings as they are unless you have specific preferences.

3. **Verify the installation**: Open the command prompt and run `git --version`. You should see the installed Git version displayed.

#### Linux

1. **Package Manager**: Use your distribution's package manager to install Git. For example, on Ubuntu, run `sudo apt-get install git`.

2. **Verify the installation**: Open the terminal and run `git --version`. You should see the installed Git version displayed.

### Installing GitHub CLI (gh)

#### Windows

1. **Download GitHub CLI (gh)**: Visit the official GitHub CLI repository (https://github.com/cli/cli) and download the latest version of gh for Windows.

2. **Run the installer**: Double-click the downloaded installer and follow the on-screen instructions. Leave the default settings as they are unless you have specific preferences.

3. **Verify the installation**: Open the command prompt and run `gh --version`. You should see the installed gh version displayed.

#### Linux

1. **Package Manager**: Use your distribution's package manager to install GitHub CLI. For example, on Ubuntu, run `sudo apt-get install gh`.

2. **Verify the installation**: Open the terminal and run `gh --version`. You should see the installed gh version displayed.

## Git Workflow

### Committing Changes

1. **Stage changes**: Use the `git add` command to stage the changes you want to commit. For example, `git add file1.js` stages changes in `file1.js`.

2. **Commit changes**: Use the `git commit` command to create a commit with a descriptive message. For example, `git commit -m "Add new feature"` creates a commit with the message "Add new feature".

### Pushing Changes

1. **Push to a branch**: Use the `git push` command to push your committed changes to a specific branch. For example, `git push origin main` pushes your changes to the `main` branch.

### Pulling Changes

1. **Fetch changes**: Use the `git fetch` command to fetch the latest changes from a remote repository. For example, `git fetch origin` fetches the latest changes from the `origin` remote.

2. **Merge changes**: Use the `git merge` command to merge the fetched changes into your local branch. For example, `git merge origin/main` merges the changes from the `origin/main` branch into your current branch.

## Command Reference

- `git add <file>`: Stages changes in the specified file.
- `git commit -m "<message>"`: Creates a commit with the specified message.
- `git push <remote> <branch>`: Pushes your committed changes to the specified remote branch.
- `git fetch <remote>`: Fetches the latest changes from the specified remote repository.
- `git merge <branch>`: Merges changes from the specified branch into your current branch.

## Feedback and Contributions

We encourage feedback and contributions to improve our organization's guidelines. If you have any suggestions or questions, feel free to open an issue or submit a pull request.

Happy coding!
