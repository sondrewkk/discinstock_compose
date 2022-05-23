print('Start #################################################################');

db = db.getSiblingDB('discinstock');
db.createUser(
    {
        user: 'discinstock_user',
        pwd: 'hoIF2dq5G34zus2H',
        roles: [{ role: 'readWrite', db: 'discinstock' }],
    },
);

db.createCollection('users');

db.users.insertOne(
    {
        username: 'discinstock',
        hashed_password: '$2b$12$4ACWds/J32dkX.pH6RtFPOc6L5CcxNsl2YTWHcxADnzhfUlDu8ntC'
    }
);

print('END #################################################################');