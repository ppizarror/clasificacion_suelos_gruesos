function c = get_sand_group_name( pfines, cu, cc, fines, pgravel )
%GET_SAND_GROUP_NAME Retorna la clasificaci�n de la arena.
%   C = GET_SAND_GROUP_NAME(PFINES, CU, CC, FINES, PSAND)
%   retorna el nombre del grupo de la arena con PFINES porcentaje de finos, CU
%   y CC valores del coeficiente de uniformidad y coeficiente de forma
%   respectivamente, tipo de finos FINES y porcentaje de grava PGRAVEL.
%
%   PFINES: N�mero entre 0 y 100 [%].
%   CU: N�mero entre 0 y 100.
%   CC: N�mero entre 0 y 100.
%   FINES: String (ML, MH, CL-CH, CL-ML, CL-CH, CL-ML).
%   PGRAVEL: N�mero entre 0 y 100 [%].

    % Se obtienen los �ndices seg�n los par�metros de la clasificaci�n
    f = indx_fines_p(pfines);
    cucc = indx_cucc(cu, cc, 1);
    tf = indx_fines_n(fines);
    ps = indx_sg_percentage(pgravel, 0);
    t_prop = [f, cucc, tf, -1, ps];
    
    % Se carga la lista de grupos para las gravas
    try
        sand_list = load('sand_groupname.mat');
    catch ME
        error('Sand group name does not exist, please execute the following command: generate_groupnames');
    end
    sand_list = sand_list.list;
    sand_list_size = length(sand_list);
    
    % Se busca el elemento en la lista
    for i=1:sand_list_size
        propr = sand_list{i,1}; % Se obtienen las propiedades del grupo
        if isequal_gn(t_prop, propr)
            c = sand_list{i,2};
            return
        end
    end
    
    % Si no se encuentra se lanza error
    error('Sand classification (group name) does not exist');

end

