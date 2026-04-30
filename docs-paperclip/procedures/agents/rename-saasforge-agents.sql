-- Rename SaaSForge agents to human names
UPDATE agents SET name = 'Config Kai', title = 'Configuration Specialist', updated_at = NOW()
WHERE id = 'd436cb88-7994-4214-b2ee-5b7a5e15435a';

UPDATE agents SET name = 'Deploy Drew', title = 'Deployment Coordinator', updated_at = NOW()
WHERE id = '62bbb46e-cdf5-4771-b85f-ffb1288d1e0b';

UPDATE agents SET name = 'Git Ginny', title = 'GitHub Specialist', updated_at = NOW()
WHERE id = 'bf651478-ade4-47c4-803c-5257b97d85e1';

UPDATE agents SET name = 'Render Ryan', title = 'Render Specialist', updated_at = NOW()
WHERE id = 'ec0ba9ed-e71c-481f-a556-de052823b56b';

-- Verify the changes
SELECT id, name, title FROM agents WHERE id IN (
  'd436cb88-7994-4214-b2ee-5b7a5e15435a',
  '62bbb46e-cdf5-4771-b85f-ffb1288d1e0b',
  'bf651478-ade4-47c4-803c-5257b97d85e1',
  'ec0ba9ed-e71c-481f-a556-de052823b56b'
);
