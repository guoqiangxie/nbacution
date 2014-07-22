package com.useeasy.frame.hibernate;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.QueryException;
import org.hibernate.dialect.function.SQLFunction;
import org.hibernate.engine.Mapping;
import org.hibernate.engine.SessionFactoryImplementor;
import org.hibernate.type.Type;

public class BitXorFunction implements SQLFunction {

	  public Type getReturnType(Type type, Mapping mapping) {
	    return Hibernate.INTEGER;
	  }

	  public boolean hasArguments() {
	    return true;
	  }

	  public boolean hasParenthesesIfNoArguments() {
	    return true;
	  }

	  @SuppressWarnings("unchecked")
	  public String render(List args, SessionFactoryImplementor factory) throws QueryException {
	    if (args.size() != 2) {
	      throw new IllegalArgumentException("BitXorFunction requires 2 arguments!");
	    }
	    return args.get(0).toString() + " ^ " + args.get(1).toString();
	  }

	}
