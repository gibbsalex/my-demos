classdef link
    properties
        x_s {mustBeNumeric}
        x_e {mustBeNumeric}
        y_s {mustBeNumeric}
        y_e {mustBeNumeric}
        len {mustBeNumeric}
        ang_init {mustBeNumeric}
    end
    methods
        function obj = link(x_s, x_e, y_s, y_e)
            obj.x_s = x_s;
            obj.x_e = x_e;
            obj.y_s = y_s;
            obj.y_e = y_e;
            obj.len = sqrt((x_e - x_s)^2 + (y_e - y_s)^2);
            obj.ang_init = atan2((y_e - y_s),(x_e - x_s));
        end
    end
end