package com.squireofsoftware.peopleproject.graphql;

import com.netflix.graphql.dgs.*;
import com.squireofsoftware.peopleproject.entities.Person;
import com.squireofsoftware.peopleproject.jpas.JpaPerson;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@DgsComponent
public class PersonFetcher {
    private final JpaPerson personDao;

    public PersonFetcher(JpaPerson personDao) {
        this.personDao = personDao;
    }

    @DgsQuery
    public List<Person> people(@InputArgument Integer id) {
        if(id == null) {
            return personDao.findAll();
        }

        return personDao.findById(id)
                .map(Collections::singletonList)
                .orElse(Collections.emptyList());
    }

    @DgsQuery
    public Person person(@InputArgument Integer id) {
        return personDao.findById(id).orElse(null);
    }

    @DgsEntityFetcher(name = "Person")
    public Person person(Map<String, Object> values) {
        return personDao.findById((Integer) values.get("id"))
                .orElse(null);
    }
}
