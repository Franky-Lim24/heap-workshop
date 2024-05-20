from pydantic import BaseModel, Field
from typing import Optional
from datetime import date

class BookBase(BaseModel):
    title: str
    author: str
    genre: str
    published_date: Optional[date] = None
    description: Optional[str] = None

class BookCreate(BookBase):
    pass

class Book(BookBase):
    id: int

    class Config:
        orm_mode = True
        json_encoders = {
            date: lambda v: v.isoformat()
        }
