{
  "name": "edit-task",
  "steps": [
    {
      "id": "precheck",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && git status --porcelain && git rev-parse --abbrev-ref HEAD && git rev-parse --short HEAD\""
    },
    {
      "id": "checkout",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && git checkout -B lobster/ktb-26\""
    },
    {
      "id": "show_spec",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && test -f KTB-26-LOBSTER-TASK.md && sed -n '1,220p' KTB-26-LOBSTER-TASK.md\""
    },
    {
      "id": "implement",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && ./tools/apply_task.sh --spec KTB-26-LOBSTER-TASK.md\""
    },
    {
      "id": "test",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && ./gradlew test --no-daemon\""
    },
    {
      "id": "diff_preview",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && git diff --stat && echo '---' && git diff | sed -n '1,240p'\"",
      "approval": "required"
    },
    {
      "id": "commit",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && git add -A && git commit -m 'KTB-26: dictionary upload via document file' || echo 'No changes to commit'\"",
      "condition": "$diff_preview.approved"
    },
    {
      "id": "summary",
      "command": "bash -lc \"cd /home/renat/KotlinTelegramBot && git log --oneline -n 1 && echo '---' && git status --short\""
    }
  ]
}
