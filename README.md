# COMMANDS

## Add Projects

```PowerShell
Add-Project <PROJECT_NAME> [FRAMEWORK] [MAIN_FILE_EXTENSION] [ADDITIONAL_FRAMEWORK_PARAMS]
```

## Get info Projects

```PowerShell
Get-Project <MODE> [PROJECT_NAME | PATH]
```

### Modes

```
1. a      List all projects
            ==> List the name of the all projects.
2. s      Set location to Project
            ==> Goes to the specified project directory.
3. c      Set path to projects
            ==> Set the path to the projects directory.
4. m      Create a new project from the current directory.
            ==> The current directory turns into a new project and is moved to projects directory.
```

## New Test

## Return path before test

--

# TODO

- [x] project: add a new simple project
- [x] project: ... with framework
- [x] project: ... with extension
- [ ] project: manage projects
- [ ] project: mode `a`
- [ ] project: mode `s`
- [ ] project: mode `c`
- [ ] project: mode `m`
- [ ] test: add new test
