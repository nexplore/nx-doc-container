# nx-doc-container

nx-doc-container is a developer-centric tool that transforms your markdown documentation into polished PDF documents, ideal for external stakeholders such as project managers and test engineers.
It ensures your documentation is professionally formatted with Pandoc, complete with all necessary dependencies.
By leveraging a Docker container, it runs seamlessly across platforms and provides a controlled and consistent build environment, eliminating version conflicts and setup complexities.

## Features

- Supports markdown and graphs using DrawIO.
- Allows for versioning of the documentation.
- Generate PDFs out of the box without requiring to dive into the abyss of the dependency hell.

## Installation

To install nx-doc-container, follow these steps:

```bash
git clone https://github.com/nexplore/nx-doc-container.git
cd nx-doc-container/docs_pandoc
docker compose up
```

> [!NOTE]
> This will pull the required Docker images and run the package-update & generation process once.

## Usage

1. Write content. Add your documentation to the `docs` folder. Use images and other elements as needed.

> [!TIP]
> Optionally, update meta data for the generated PDF in `docs_pandoc/build.sh`.

2. Generate the document. Either run `docker compose up` in the `docs_pandoc` dir, or open the `docs_pandoc` folder as a Dev Container in Visual Studio Code. (Optionally, run "Rebuild and Reopen in Container" command.)

### Adding runtime diagrams from Mermaid

You can integrate charts generated in Mermaid using draw.io:

- Open draw.io
- Click Arrange > Insert > Advanced > Mermaid. Alternatively, click the + icon in the toolbar, then select Advanced > Mermaid.
- Enter your Mermaid code.

### Adding comments

You can use html comment tags in Markdown files. Comments are not rendered in the PDF.

```html
<!-- my comment -->
```

### Including subfiles with different heading level

Use parameter `shift-heading-level-by` when including a file to add additional levels for heading calculation.

````markdown
```{.include shift-heading-level-by=2}
08_security_app_auth_hash.md
```
````

### Integrate nx-doc-container in your Azure DevOps build pipeline

```yml
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
