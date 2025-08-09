"""Tests for ACF CLI main module."""

import pytest
from click.testing import CliRunner

from acf.main import main, install, status


class TestMainCLI:
    """Test cases for main CLI functionality."""
    
    def setup_method(self):
        """Setup test runner."""
        self.runner = CliRunner()
    
    def test_main_group_help(self):
        """Test main command shows help."""
        result = self.runner.invoke(main, ["--help"])
        assert result.exit_code == 0
        assert "AI Code Forge configuration management tool" in result.output
    
    def test_main_version(self):
        """Test version option works."""
        result = self.runner.invoke(main, ["--version"])
        assert result.exit_code == 0
        assert "0.1.0" in result.output
    
    def test_install_command(self):
        """Test install command executes."""
        result = self.runner.invoke(install)
        assert result.exit_code == 0
        assert "Installing configuration..." in result.output
    
    def test_status_command(self):
        """Test status command executes."""
        result = self.runner.invoke(status)
        assert result.exit_code == 0
        assert "Checking status..." in result.output
    
    def test_install_via_main_group(self):
        """Test install command via main group."""
        result = self.runner.invoke(main, ["install"])
        assert result.exit_code == 0
        assert "Installing configuration..." in result.output
    
    def test_status_via_main_group(self):
        """Test status command via main group."""
        result = self.runner.invoke(main, ["status"])
        assert result.exit_code == 0
        assert "Checking status..." in result.output