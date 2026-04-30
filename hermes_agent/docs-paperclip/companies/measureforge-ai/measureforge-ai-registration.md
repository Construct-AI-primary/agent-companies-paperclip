# MeasureForge AI Registration

## Database Registration Process

To properly integrate MeasureForge AI into the system, we need to follow these steps:

1. **Schema Update**: Register the new company and its agents in `packages/db/src/schema/*.ts`.
2. **Migration Generation**: After updating the schema, generate a migration to update the database structure. Use the command:
   ```sh
   pnpm db:generate
   ```
3. **Type Check**: Validate that the new changes compile correctly with:
   ```sh
   pnpm -r typecheck
   ```
4. **Run Tests**: Confirm that everything is functioning as expected by running:
   ```sh
   pnpm -r test:run
   ```
5. **Build**: Finally, ensure the project can be built successfully:
   ```sh
   pnpm build
   ```

## Verification Steps
Confirm that the database has properly populated entries for:
- MeasureForge AI as a company in the companies table.
- Each agent with its respective skills linked in the agents table.
- Skills correctly associated under the skills table.

Once verified, the MeasureForge AI should be fully functional within the ecosystem, ready for use in construction and engineering workflows.