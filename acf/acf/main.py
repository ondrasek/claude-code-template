"""Main CLI entry point."""

import click

@click.group()
@click.version_option()
def main():
    """AI Code Forge configuration management tool."""
    pass

@main.command()
def install():
    """Install AI Code Forge configuration."""
    click.echo("Installing configuration...")

@main.command()  
def status():
    """Show installation status."""
    click.echo("Checking status...")

if __name__ == "__main__":
    main()