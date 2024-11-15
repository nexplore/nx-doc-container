# NxDocContainer

NxDocContainer is a project designed to generate a beautiful pdf document from your markdown documentation.

As a developer, you just document your project as before - and NxDocContainer generates the PDF document for your external stakeholders as project manager or test engineer.

It uses a docker container to run pandoc in the right version and the required dependency and works out of the box even on your Windows machine using Visual Studio Code.

## Features

- Write your doc in markdown and add graphs using DrawIO.
- Versionize your doc along the application changes.
- Generate pdfs out of the box without dependency hell.

## Installation

To install NxDocContainer, follow these steps:

```bash
git clone https://github.com/yourusername/NxDocContainer.git
```

## Usage

### Write content

Add your documentation to the docs folder. Use images and other elements.

Optional, update meta data for the generated PDF in docs_pandoc/build.sh in the parameters.

### Generate pdf

Open the docs_pandoc folder as Dev Container in Visual Studio Code.
Optional, run "Rebuild and Reopen in Container" command.

```bash
./build.sh
```
### Generate pdf in your Azure DevOps build pipeline

```
  - stage: Document
    displayName: "🔍 Generate 🤖 documentation"
    condition: succeeded()
    jobs:
      - job: BuildAndDocument
        displayName: "➡️ Documenting..."
        steps:
          - script: |
              docker compose -f docs_pandoc/docker-compose.yml up --build docs-pandoc-generate-docs
            displayName: "➡️ Running pandoc container and building documentation"
            env:
              ENVIRONMENT: build

          - task: CopyFiles@2
            inputs:
              sourceFolder: "."
              contents: |
                **/docs/doc.pdf
              targetFolder: "$(Build.ArtifactStagingDirectory)"
            displayName: "➡️ Copy generated documentation"
            condition: always()

          - task: PublishBuildArtifacts@1
            inputs:
              pathToPublish: "$(Build.ArtifactStagingDirectory)"
              artifactName: "build_outputs"
            displayName: "➡️ Publish results"
            condition: always()

          - script: |
              docker compose -f docs_pandoc/docker-compose.yml down
            displayName: "➡️ Cleanup containers"
            condition: always()
```

## Contributing

We welcome contributions! Please read our [contributing guidelines](CONTRIBUTING.md) before getting started.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

