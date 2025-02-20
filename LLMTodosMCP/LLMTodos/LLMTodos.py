from typing import Any
import httpx
from mcp.server.fastmcp import FastMCP
from pathlib import Path
import re

# Initialize FastMCP server
mcp = FastMCP("LLMTodos")



class TypstFunc():
    def __init__(self, project_dir: str):
        super().__init__()
        self.project_dir = Path(project_dir)
        self.tag_pattern = r'#LLMTODO\[(.*?)\]'

    async def handle_read_files(self, _):
        """Read all Typst files in the project"""
        files = {}
        
        # Read main.typ
        main_path = self.project_dir / "main.typ"
        if main_path.exists():
            files["main.typ"] = main_path.read_text()

        # Read sections/*.typ
        sections_dir = self.project_dir / "sections"
        if sections_dir.exists():
            for file_path in sections_dir.glob("*.typ"):
                files[str(file_path.relative_to(self.project_dir))] = file_path.read_text()

        return {"files": files}

    async def handle_process_tasks(self, _):
        """Extract all LLMTODO tasks from files"""
        files = (await self.handle_read_files(None))["files"]
        tasks = {}

        for file_path, content in files.items():
            file_tasks = []
            for match in re.finditer(self.tag_pattern, content, re.DOTALL):
                file_tasks.append({
                    "task": match.group(1).strip(),
                    "span": [match.start(), match.end()],
                    "full_match": match.group(0)
                })
            if file_tasks:
                tasks[file_path] = file_tasks

        return {"tasks": tasks}

    #async def handle_write_files(self, params):
    #    """Write updated content back to files"""
    #    updates = params.get("updates", {})
    #    
    #    for rel_path, new_content in updates.items():
    #        file_path = self.project_dir / rel_path
    #        
    #        # Create backup
    #        backup_path = file_path.with_suffix(file_path.suffix + '.bak')
    #        await backup_path.write_text(await file_path.read_text())
    #        
    #        # Write new content
    #        await file_path.write_text(new_content)

    #    return {"status": "success"}

@mcp.tool()
async def fill_in_todos(project_dir: str) -> str:
    """
    Fill in all LLMTODOs in the project files.
    """
    typst = TypstFunc(project_dir)
    files = (await typst.handle_read_files(None))["files"]
    tasks = (await typst.handle_process_tasks(None))["tasks"]

    return f"Files: {files}\n--\n Tasks: {tasks} \n\n For each answer respond with a wrapping of ```ANSWER``` and use Typst markup"

if __name__ == "__main__":
    # Initialize and run the server
    mcp.run(transport='stdio')
