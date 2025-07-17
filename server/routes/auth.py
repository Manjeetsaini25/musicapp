from fastapi import HTTPException
import uuid
import bcrypt
import jwt
import database as dtb
from middleware.auth_middleware import auth_middleware
from modals import user_create, base, user_login
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy.orm import joinedload

get_db = dtb.get_db
UserCreate = user_create.UserCreate
User = base.User
Base = base.Base
router = APIRouter()
UserLogin = user_login.UserLogin

@router.post('/signup', status_code=201)
def signup_user(user: UserCreate, db:Session=Depends(get_db)):
    existing_user = db.query(User).filter(User.email == user.email).first()
    
    if existing_user:
        raise HTTPException(400, "User with the same email already exists!")
        return
    
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    new_user = User(
        id=str(uuid.uuid4()),
        email=user.email,
        name=user.name,
        password=hashed_pw
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.post('/login')
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if not user_db:
        raise HTTPException(400, "User with this email don't exists!")
    
    ismatch = bcrypt.checkpw(user.password.encode(), user_db.password)
    if not ismatch:
        raise HTTPException(400, 'INCORRECT PASSWORD')
    
    token = jwt.encode({'id': user_db.id}, 'password_key')
    return {'token':token, 'user':user_db}

@router.get('/')
def current_user_data(db: Session=Depends(get_db), 
                      user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(
        joinedload(User.favorites)
    ).first()

    if not user:
        raise HTTPException(404, 'User not found!')
    
    return user