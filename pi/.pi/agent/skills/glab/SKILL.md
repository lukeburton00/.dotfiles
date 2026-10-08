---
name: glab
description: Use the GitLab glab CLI to discover, inspect, and merge merge requests across projects, check approvals and pipelines, and diagnose merge failures. Use for GitLab MR workflows, especially requests concerning the authenticated user's MRs.
compatibility: Requires glab installed and authenticated to the relevant GitLab host.
---

# GitLab CLI workflows

## Discover and inspect

- Run `glab auth status` to identify the authenticated account and host. Never expose tokens or read credential stores.
- Consult `glab <command> --help` for installed-version flags rather than assuming GitHub CLI syntax.
- Outside a repository, use explicit `-R GROUP/PROJECT` for MR commands, or `glab api` for cross-project discovery.
- For the authenticated user's open MRs across projects:
  ```sh
  glab api 'merge_requests?scope=created_by_me&state=opened&search=grpc&per_page=100'
  ```
  Replace the search term appropriately. Paginate if needed; do not assume the first page is complete. Search covers title/description, not diffs. Verify changes with MR diffs when descriptions are insufficient.
- Record `project_id`, `iid`, `references.full`, `web_url`, and source `sha`. MR IIDs are project-scoped.
- Inspect current MR details and actual approval state:
  ```sh
  glab api projects/PROJECT_ID/merge_requests/IID
  glab api projects/PROJECT_ID/merge_requests/IID/approvals
  ```
- For requests specifying approved MRs, require actual approval (`approved`, `approved_by`, and applicable outstanding requirements), not merely an assigned reviewer or checked description checklist. Inspect draft status, conflicts, detailed merge status, and `head_pipeline`.
- If matching MRs are ambiguous, clarify before mutating unrelated candidates.

## Merge safely

Merge only when authorized by the current user request. A skill is not standing permission to merge, approve, deploy, or alter project settings.

```sh
glab mr merge IID -R GROUP/PROJECT --sha REVIEWED_HEAD_SHA --yes
```

- Pin `--sha` to the inspected source HEAD so new unreviewed commits are not silently merged.
- Preserve repository squash/source-branch defaults unless the user asks otherwise.
- Default auto-merge may wait for a running pipeline. Report scheduled merges as scheduled, not completed.
- Independent MRs can be processed in parallel; preserve individual results and failures.

## Manual pipelines and HTTP 405

An HTTP 405 from the merge endpoint is not sufficient to identify the cause. Re-fetch MR details and examine `detailed_merge_status`, `merge_error`, `head_pipeline.status`, and approvals.

Observed with glab: approved, non-draft MRs reported `mergeable` but had a `manual` pipeline (waiting for manual action). Default auto-merge returned HTTP 405, while a normal immediate merge succeeded:

```sh
glab mr merge IID -R GROUP/PROJECT --sha REVIEWED_HEAD_SHA --auto-merge=false --yes
```

Only consider this retry when the user authorized merging and current details indicate the MR is eligible. It disables waiting/auto-merge; GitLab still enforces server-side merge requirements. Do not generalize this into permission to bypass required CI checks. Never play manual jobs (which may deploy), change approvals or branch protections, or disable checks just to make a merge succeed. If blocked by requirements, explain the blocker and ask for direction.

## Verify and report

After merging or an ambiguous response, re-fetch the MR and confirm `state` is `merged`. For auto-merge, inspect scheduling state instead. Report each outcome with its MR link; distinguish merged, scheduled, and blocked. Do not claim that pipelines passed merely because an immediate merge succeeded.
