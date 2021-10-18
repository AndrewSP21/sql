
-- ii. �������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������
SELECT DISTINCT firstname 
	FROM users
	ORDER BY firstname ASC;


-- iii. �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = false). 
-- �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = true (��� 1)


ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT TRUE;
UPDATE profiles SET is_active = FALSE WHERE YEAR (birthday) > (2021-18);



iv. �������� ������, ��������� ��������� ��� �������� (���� ������ �����������)

SELECT created_at FROM messages;
DELETE FROM messages WHERE created_at > now();


v. �������� �������� ���� ��������� ������� (� �����������)
���� ������ ����� ���������.