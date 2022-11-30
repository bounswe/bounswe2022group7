package com.group7.artshare.utils

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import java.util.*
import javax.persistence.Converter
import javax.persistence.AttributeConverter

@Converter
class StringToListConverter : AttributeConverter<List<String>, String>{

    override fun convertToDatabaseColumn(fields : List<String>) : String {
        try{
            var mapper: ObjectMapper = ObjectMapper()
            return mapper.writeValueAsString(fields)
        }catch(e : Exception){
            return ""
        }
    }


    override fun convertToEntityAttribute(data : String) : List<String> {
        if (Objects.isNull(data))
            return mutableListOf<String>()
        try {
            var mapper: ObjectMapper = ObjectMapper()
            return mapper.readValue<List<String>>(data)
        } catch (e: Exception) {
            return mutableListOf<String>()
        }
    }
}